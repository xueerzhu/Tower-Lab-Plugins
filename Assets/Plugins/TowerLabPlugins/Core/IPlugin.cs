namespace TowerLab.Plugins.Core
{
    /// <summary>
    /// Base interface that all Tower Lab plugins must implement
    /// </summary>
    public interface IPlugin
    {
        /// <summary>
        /// Unique identifier for this plugin
        /// </summary>
        string PluginId { get; }
        
        /// <summary>
        /// Human-readable name of the plugin
        /// </summary>
        string DisplayName { get; }
        
        /// <summary>
        /// Version of the plugin
        /// </summary>
        string Version { get; }
        
        /// <summary>
        /// Description of what this plugin does
        /// </summary>
        string Description { get; }
        
        /// <summary>
        /// Initialize the plugin. Called when the plugin is loaded.
        /// </summary>
        void Initialize();
        
        /// <summary>
        /// Cleanup resources. Called when the plugin is unloaded.
        /// </summary>
        void Shutdown();
        
        /// <summary>
        /// Whether the plugin is currently enabled and active
        /// </summary>
        bool IsActive { get; }
    }
}