using UnityEngine;

namespace AllIn13DShader
{
	public class EffectsExtraData : ScriptableObject
	{
		[System.Serializable]
		public class ExtraData
		{
			public string effectID;
			public string docURL;
			public MessageByKeywords[] customMessages;
		}

		[System.Serializable]
		public class MessageByKeywords
		{
			[TextArea]public string message;
			public string[] keywords;

			public bool IsMessageEnabled(MaterialInfo targetMatInfo)
			{
				bool res = false;

				if (keywords.Length == 0)
				{
					res = true;
				}
				else
				{
					for (int i = 0; i < keywords.Length; i++)
					{
						if (targetMatInfo.IsKeywordEnabled(keywords[i]))
						{
							res = true;
							break;
						}
					}
				}

				return res;
			}
		}

		public ExtraData[] effectsExtraData;

		public ExtraData GetExtraDataByEffectID(string effectID)
		{
			ExtraData res = null;

			for(int i = 0; i < effectsExtraData.Length; i++)
			{
				if (effectsExtraData[i].effectID == effectID)
				{
					res = effectsExtraData[i];
					break;
				}
			}

			return res;
		}
	}
}