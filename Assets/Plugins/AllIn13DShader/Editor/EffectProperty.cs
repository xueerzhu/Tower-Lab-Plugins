using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace AllIn13DShader
{
	[System.Serializable]
	public class EffectProperty
	{
		[SerializeReference] public AllIn13DEffectConfig parentEffect;

		public int propertyIndex;
		public string propertyName;
		public string displayName;
		
		public List<string> keywords;
		public List<string> incompatibleKeywords;
		public List<string> propertyKeywords;

		public KeywordsOp keywordsOp;
		public bool allowReset;

		public ShaderPropertyType shaderPropertyType;

		public bool isHDR;
		public bool hasTilingAndOffset;

		public EffectProperty(AllIn13DEffectConfig parentEffect, int propertyIndex, string propertyName, string displayName, 
			KeywordsOp keywordsOp, bool allowReset, ShaderPropertyType shaderPropertyType, ShaderPropertyFlags shaderPropertyFlags)
		{
			this.parentEffect = parentEffect;

			this.keywords = new List<string>();
			this.incompatibleKeywords = new List<string>();
			this.propertyKeywords = new List<string>();

			this.propertyIndex = propertyIndex;
			this.propertyName = propertyName;
			this.displayName = displayName;

			this.keywordsOp = keywordsOp;
			this.allowReset = allowReset;

			this.shaderPropertyType = shaderPropertyType;

			this.isHDR = shaderPropertyFlags.HasFlag(ShaderPropertyFlags.HDR);
			this.hasTilingAndOffset = !shaderPropertyFlags.HasFlag(ShaderPropertyFlags.NoScaleOffset) && shaderPropertyType == ShaderPropertyType.Texture;
		}

		public void AddKeyword(string keyword)
		{
			this.keywords.Add(keyword);
		}

		public void AddIncompatibleKeyword(string keyword)
		{
			this.incompatibleKeywords.Add(keyword);
		}

		public void AddPropertyKeywords(List<string> propertyKeywordsToAdd)
		{
			for(int i = 0; i < propertyKeywordsToAdd.Count; i++)
			{
				this.propertyKeywords.Add(propertyKeywordsToAdd[i]);
			}
		}

		public bool IsPropertyWithKeywords()
		{
			bool res = propertyKeywords.Count > 0;
			return res;
		}

		public bool IsToggleProperty()
		{
			bool res = propertyKeywords.Count == 1;
			return res;
		}

		public bool IsEnumProperty()
		{
			bool res = propertyKeywords.Count >= 2;
			return res;
		}
	}
}