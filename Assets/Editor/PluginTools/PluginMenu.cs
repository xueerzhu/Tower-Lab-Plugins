using UnityEngine;
using UnityEditor;
using TowerLab.Plugins.Core;

namespace TowerLab.Plugins.Editor
{
    public static class PluginMenu
    {
        [MenuItem("Tower Lab/Plugin Tools/Create Plugin GameObject")]
        public static void CreatePluginGameObject()
        {
            var go = new GameObject("New Plugin");
            Selection.activeGameObject = go;
            
            Debug.Log("Created new plugin GameObject. Add your custom plugin component to it.");
        }
        
        [MenuItem("Tower Lab/Plugin Tools/List Active Plugins")]
        public static void ListActivePlugins()
        {
            var plugins = Object.FindObjectsOfType<PluginBase>();
            
            if (plugins.Length == 0)
            {
                Debug.Log("No active plugins found in the scene.");
                return;
            }
            
            Debug.Log($"Found {plugins.Length} plugin(s):");
            foreach (var plugin in plugins)
            {
                var status = plugin.IsActive ? "Active" : "Inactive";
                Debug.Log($"- {plugin.DisplayName} ({plugin.PluginId}) v{plugin.Version} - {status}");
            }
        }
        
        [MenuItem("Tower Lab/Plugin Tools/Plugin Development Guide")]
        public static void OpenPluginGuide()
        {
            Application.OpenURL("https://github.com/xueerzhu/Tower-Lab-Plugins/wiki");
        }
    }
}