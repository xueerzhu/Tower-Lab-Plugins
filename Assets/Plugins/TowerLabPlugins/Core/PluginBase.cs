using UnityEngine;

namespace TowerLab.Plugins.Core
{
    /// <summary>
    /// Base class for Tower Lab plugins providing common functionality
    /// </summary>
    public abstract class PluginBase : MonoBehaviour, IPlugin
    {
        [SerializeField] private string pluginId;
        [SerializeField] private string displayName;
        [SerializeField] private string version = "1.0.0";
        [SerializeField] private string description;
        
        private bool isActive;
        
        public virtual string PluginId => pluginId;
        public virtual string DisplayName => displayName;
        public virtual string Version => version;
        public virtual string Description => description;
        public virtual bool IsActive => isActive;
        
        protected virtual void Awake()
        {
            if (string.IsNullOrEmpty(pluginId))
            {
                pluginId = GetType().Name;
            }
        }
        
        protected virtual void Start()
        {
            Initialize();
        }
        
        protected virtual void OnDestroy()
        {
            if (isActive)
            {
                Shutdown();
            }
        }
        
        public virtual void Initialize()
        {
            if (isActive) return;
            
            Debug.Log($"[{DisplayName}] Plugin initialized");
            isActive = true;
            OnInitialize();
        }
        
        public virtual void Shutdown()
        {
            if (!isActive) return;
            
            Debug.Log($"[{DisplayName}] Plugin shutting down");
            isActive = false;
            OnShutdown();
        }
        
        /// <summary>
        /// Called when the plugin is initialized. Override in derived classes.
        /// </summary>
        protected virtual void OnInitialize() { }
        
        /// <summary>
        /// Called when the plugin is shut down. Override in derived classes.
        /// </summary>
        protected virtual void OnShutdown() { }
    }
}