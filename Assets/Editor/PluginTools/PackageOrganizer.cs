using UnityEngine;
using UnityEditor;
using System.IO;

namespace TowerLab.Plugins.Editor
{
    public static class PackageOrganizer
    {
        [MenuItem("Tower Lab/Plugin Tools/Organize Imported Assets")]
        public static void OrganizeImportedAssets()
        {
            var selectedAssets = Selection.objects;
            
            if (selectedAssets.Length == 0)
            {
                EditorUtility.DisplayDialog("No Selection", 
                    "Please select the assets you want to move to Assets/Plugins/", "OK");
                return;
            }
            
            var pluginName = EditorUtility.SaveFolderPanel(
                "Choose Plugin Name", 
                "Assets/Plugins", 
                "NewPlugin");
                
            if (string.IsNullOrEmpty(pluginName))
                return;
                
            var pluginFolderName = Path.GetFileName(pluginName);
            var targetPath = $"Assets/Plugins/{pluginFolderName}";
            
            // Create target directory if it doesn't exist
            if (!Directory.Exists(targetPath))
            {
                Directory.CreateDirectory(targetPath);
                AssetDatabase.Refresh();
            }
            
            foreach (var asset in selectedAssets)
            {
                var assetPath = AssetDatabase.GetAssetPath(asset);
                if (assetPath.StartsWith("Assets/") && !assetPath.StartsWith("Assets/Plugins/"))
                {
                    var fileName = Path.GetFileName(assetPath);
                    var newPath = $"{targetPath}/{fileName}";
                    
                    var result = AssetDatabase.MoveAsset(assetPath, newPath);
                    if (string.IsNullOrEmpty(result))
                    {
                        Debug.Log($"Moved: {assetPath} → {newPath}");
                    }
                    else
                    {
                        Debug.LogError($"Failed to move {assetPath}: {result}");
                    }
                }
            }
            
            AssetDatabase.Refresh();
            Debug.Log($"Organized assets into {targetPath}");
        }
        
        [MenuItem("Tower Lab/Plugin Tools/Create Plugin Folder")]
        public static void CreatePluginFolder()
        {
            var folderName = EditorUtility.SaveFolderPanel(
                "Create Plugin Folder", 
                "Assets/Plugins", 
                "NewPlugin");
                
            if (string.IsNullOrEmpty(folderName))
                return;
                
            var pluginName = Path.GetFileName(folderName);
            var pluginPath = $"Assets/Plugins/{pluginName}";
            
            if (!Directory.Exists(pluginPath))
            {
                Directory.CreateDirectory(pluginPath);
                AssetDatabase.Refresh();
                
                // Create README for the plugin
                var readmePath = $"{pluginPath}/README.md";
                File.WriteAllText(readmePath, $"# {pluginName}\n\nPlugin reference and documentation.\n");
                
                AssetDatabase.Refresh();
                Debug.Log($"Created plugin folder: {pluginPath}");
                
                // Select the folder in Project window
                var folderAsset = AssetDatabase.LoadAssetAtPath<DefaultAsset>(pluginPath);
                Selection.activeObject = folderAsset;
                EditorGUIUtility.PingObject(folderAsset);
            }
            else
            {
                Debug.LogWarning($"Folder already exists: {pluginPath}");
            }
        }
    }
}