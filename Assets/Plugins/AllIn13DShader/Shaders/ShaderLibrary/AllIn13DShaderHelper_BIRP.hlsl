#ifndef ALLIN13DSHADER_HELPER_BIRP_INCLUDED
#define ALLIN13DSHADER_HELPER_BIRP_INCLUDED

#include "AutoLight.cginc"

#define OBJECT_TO_WORLD_MATRIX unity_ObjectToWorld

#ifdef REQUIRE_SCENE_DEPTH

	UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);

	float GetRawDepth(float4 projPos)
	{
		//float res = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(projPos));
		float res = tex2Dproj(_CameraDepthTexture, projPos);
		return res;
	}

	float GetLinearDepth01(float4 projPos)
	{
		float rawDepth = GetRawDepth(projPos);
		float res = Linear01Depth (rawDepth);

		return res;
	}

	float GetSceneDepthDiff(float4 projPos)
	{
		float rawDepth = GetRawDepth(projPos);
		float res = LinearEyeDepth(rawDepth) - projPos.z;
		return res;
	}

#endif

float3 GetNormalWS(float3 normalOS)
{
	float3 normalWS = UnityObjectToWorldNormal(normalOS);
	return normalWS;
}

float3 GetViewDirWS(float3 vertexWS)
{
	float3 res = UnityWorldSpaceViewDir(vertexWS);
	return res;
}

float3 GetPositionVS(float3 positionOS)
{
	float3 res = UnityObjectToViewPos(positionOS);
	return res;
}

float3 GetPositionWS(float4 positionOS)
{
	return mul(unity_ObjectToWorld, positionOS).xyz;
}

float3 GetDirWS(float4 dirOS)
{
	return mul(unity_ObjectToWorld, float4(dirOS.xyz, 0));
}

float3 GetDirOSFloat3(float3 dirOS)
{
	return mul(unity_WorldToObject, float4(dirOS.xyz, 0));
}

float3 GetDirOS(float4 dirOS)
{
	return mul(unity_WorldToObject, dirOS);
}

float3 GetMainLightDir(float3 vertexWS)
{
#ifdef _LIGHTMODEL_FASTLIGHTING
	float3 mainLightDir = global_lightDirection;
#else
	float3 mainLightDir = normalize(_WorldSpaceLightPos0.xyz - vertexWS * _WorldSpaceLightPos0.w);
#endif

	return mainLightDir;
}

float3 GetMainLightColorRGB()
{
#ifdef _LIGHTMODEL_FASTLIGHTING
	float3 res = global_lightColor.rgb;
#else
	float3 res = _LightColor0.rgb;
#endif

	return res;
}

float2 GetSSAO(float2 normalizedScreenSpaceUV)
{
	float2 res = float2(1, 1);
	return res;
}

//float FadeShadows (float3 worldPos, float shadowAtten) {
//	float viewZ =
//		dot(_WorldSpaceCameraPos.xyz - worldPos, UNITY_MATRIX_V[2].xyz);
//	float shadowFadeDistance =
//		UnityComputeShadowFadeDistance(worldPos, viewZ);
//	float shadowFade = UnityComputeShadowFade(shadowFadeDistance);
//	shadowAtten = saturate(shadowAtten + shadowFade);

//	return shadowAtten;
//}

float GetShadowAttenuation(EffectsData effectsData)
{ 
	float res = 1;

#if !defined(_LIGHTMODEL_FASTLIGHTING)
	UNITY_LIGHT_ATTENUATION(attenuation, effectsData, effectsData.vertexWS);
	res = attenuation;
#endif
	//attenuation = FadeShadows(effectsData.vertexWS, attenuation);
	return res;
}

AllIn1LightData GetPointLightData(float3 vertexWS, float3 normalWS, float3 lightPositionWS, float3 lightColor, float pointLightAtten, EffectsData effectsData)
{
	AllIn1LightData lightData;

	float3 lightVec = lightPositionWS - vertexWS;
	float3 lightDir = normalize(lightVec);

	float atten = 1 / (1 + dot(lightVec, lightVec) * pointLightAtten);

	lightData.lightColor = lightColor;
	lightData.lightDir = lightDir;
	
#ifdef _RECEIVE_SHADOWS_ON
	lightData.realtimeShadow = GetShadowAttenuation(effectsData);
#else
	lightData.realtimeShadow = 1.0;
#endif
	lightData.distanceAttenuation = atten;
	
	lightData.shadowColor = /*lerp(0, 1.0, lightData.realtimeShadow * lightData.distanceAttenuation)*/lightData.realtimeShadow;
	lightData.layerMask = 1.0;

	return lightData;
}

AllIn1LightData GetMainLightData(float3 vertexWS, EffectsData effectsData)
{
	AllIn1LightData lightData;
	
	#if defined(SUBTRACTIVE_LIGHTING)
		lightData.lightColor = 0;
		lightData.lightDir = GetMainLightDir(vertexWS);
		lightData.realtimeShadow = 1.0;
		lightData.distanceAttenuation = 1.0;
		lightData.shadowColor = 1.0;
	#else
		lightData.lightColor = GetMainLightColorRGB();
		lightData.lightDir = GetMainLightDir(vertexWS);

		#if defined(_LIGHTMODEL_NONE)
			lightData.realtimeShadow = 1.0;
		#else
			#ifdef _RECEIVE_SHADOWS_ON
			lightData.realtimeShadow = GetShadowAttenuation(effectsData);
			#else
			lightData.realtimeShadow = 1.0;
			#endif
		#endif
		
		#ifdef _LIGHTMODEL_FASTLIGHTING
			lightData.shadowColor = 1.0;
		#else
			#ifdef FORWARD_ADD_PASS
			lightData.shadowColor = lightData.realtimeShadow;
			#else
			lightData.shadowColor = lerp(SHADOW_COLOR, 1.0, lightData.realtimeShadow);
			#endif
		#endif

		lightData.distanceAttenuation = 1.0;
	#endif

	lightData.layerMask = 1.0;

	return lightData;
}

float3 GetPointLightPosition(int index)
{
	float3 pointLightPosition = float3(unity_4LightPosX0[index], unity_4LightPosY0[index], unity_4LightPosZ0[index]);
	return pointLightPosition;
}

AllIn1LightData GetPointLightData(int index, float3 vertexWS, float3 normalWS, EffectsData effectsData)
{
	return GetPointLightData(vertexWS, normalWS, GetPointLightPosition(index), unity_LightColor[index], unity_4LightAtten0[index], effectsData);
}

FragmentDataShadowCaster GetClipPosShadowCaster( /*VertexData v*/VertexData v, FragmentDataShadowCaster o)
{
	//float4 res = 0;
//#if defined(SHADOWS_CUBE) && !defined(SHADOWS_CUBE_IN_DEPTH_TEX)
//		// Rendering into point light (cubemap) shadows
//		//#define TRANSFER_SHADOW_CASTER_NOPOS(o,opos) o.vec = mul(unity_ObjectToWorld, v.vertex).xyz - _LightPositionRange.xyz; opos = UnityObjectToClipPos(v.vertex);
//		//#define SHADOW_CASTER_FRAGMENT(i) return UnityEncodeCubeShadowDepth ((length(i.vec) + unity_LightShadowBias.x) * _LightPositionRange.w);

//		float3 vec = mul(unity_ObjectToWorld, v.vertex).xyz - _LightPositionRange.xyz;
//		res = UnityObjectToClipPos(v.vertex);
//#else
//		// Rendering into directional or spot light shadows
//	res = UnityClipSpaceShadowCasterPos(v.vertex, v.normal);
//	res = UnityApplyLinearShadowBias(res);
//	#endif

	//res = UnityClipSpaceShadowCasterPos(v.vertex.xyz, v.normal);
	//res = UnityApplyLinearShadowBias(res);
	
	TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);
	return o;
	
	//return res; 
} 

//float GetShadowAttenuation(FragmentData i, float3 vertexWS)
//{
//	//float shadowAttenuation = UNITY_SHADOW_ATTENUATION(i, vertexWS);

//	//float3 lightCoord = mul(unity_WorldToLight, float4(vertexWS, 1)).xyz;
// //   fixed shadow = UNITY_SHADOW_ATTENUATION(i, vertexWS);
// //   float res = tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r * shadow;

//	/*TODO: Fix this*/
//	//shadowAttenuation = 1.0;

//	UNITY_LIGHT_ATTENUATION(attenuation, i, vertexWS);
	
//	return attenuation;
//}

ShadowCoordStruct GetShadowCoords(VertexData v, float4 clipPos, float3 vertexWS)
{
	ShadowCoordStruct res;

	res.pos = clipPos;
	res._ShadowCoord = 0;
	
	UNITY_TRANSFER_SHADOW(res, float2(0, 0));
	
	return res;
}
 
float3 GetLightmap(float2 uvLightmap, EffectsData data)
{
	float3 res = 0.0;
#if defined(_AFFECTED_BY_LIGHTMAPS_ON) && defined(LIGHTMAP_ON)
	res = DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap, uvLightmap));
	#ifdef SUBTRACTIVE_LIGHTING
		float attenuation = GetShadowAttenuation(data);
		float ndotl = saturate(dot(data.normalWS, _WorldSpaceLightPos0.xyz));
		float3 shadowedLightEstimate =
				ndotl * (1 - attenuation) * _LightColor0.rgb;
		float3 subtractedLight = res - shadowedLightEstimate;
		subtractedLight = max(subtractedLight, unity_ShadowColor.rgb);
		subtractedLight = lerp(subtractedLight, res, _LightShadowData.x);
	
		res = subtractedLight;
	#endif
#endif

	return res;
}

float3 GetAmbientColor(float4 normalWS)
{
	float3 res = float3(0, 0, 0);

#ifdef _CUSTOM_AMBIENT_LIGHT_ON
	res = ACCESS_PROP_FLOAT4(_CustomAmbientColor).rgb;
#else
	res = ShadeSH9(normalWS);
#endif
	
	return res;
}

//float GetFogFactor(FragmentData fragmentData)
//{
//	float res = 0;

//#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
//	UNITY_TRANSFER_FOG(fragmentData, fragmentData.pos);
//	res = fragmentData.fogCoord;
//#endif
	
//	return res;
//}

float GetFogFactor(float4 clipPos)
{
	float res = 0;
#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
	FogStruct fogStruct;
	UNITY_TRANSFER_FOG(fogStruct, clipPos);
	res = fogStruct.fogCoord;
#endif
	
	return res;
}

float4 CustomMixFog(float fogFactor, float4 col)
{
	float4 res = col;
	UNITY_APPLY_FOG(fogFactor, res);
	return res;
}

#ifdef REFLECTIONS_ON

float3 BoxProjection (
	float3 direction, float3 position,
	float4 cubemapPosition, float3 boxMin, float3 boxMax
) {
	#if UNITY_SPECCUBE_BOX_PROJECTION
		UNITY_BRANCH
		if (cubemapPosition.w > 0) {
			float3 factors =
				((direction > 0 ? boxMax : boxMin) - position) / direction;
			float scalar = min(min(factors.x, factors.y), factors.z);
			direction = direction * scalar + (position - cubemapPosition);
		}
	#endif
	return direction;
}

float3 GetReflectionsSimple(float3 worldRefl, float cubeLod, float3 positionWS)
{
	float3 res = 0;

	float3 reflUV0 = BoxProjection(worldRefl, positionWS, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax);
	float4 probe0HDR = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflUV0, cubeLod);
	float3 probe0 = DecodeHDR(probe0HDR, unity_SpecCube0_HDR);


#if UNITY_SPECCUBE_BLENDING
	float interpolator = unity_SpecCube0_BoxMin.w;

	if(interpolator < 0.99999)
    {
		float3 reflUV1 = BoxProjection(worldRefl, positionWS, unity_SpecCube1_ProbePosition, unity_SpecCube1_BoxMin, unity_SpecCube1_BoxMax);
		float4 probe1HDR = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, reflUV1, cubeLod);
		float3 probe1 = DecodeHDR(probe1HDR, unity_SpecCube1_HDR);
                    
        res = lerp(probe1, probe0, interpolator);
	}
	else
	{
		res = probe0;
	}
#endif

	return res;
}

float3 GetSkyColor(float3 positionWS, float2 normalizedScreenSpaceUV, 
	float3 normalWS, float3 viewDirWS, float cubeLod)
{
	float3 worldRefl = normalize(reflect(-viewDirWS, normalWS));
	
	float3 res = GetReflectionsSimple(worldRefl, cubeLod, positionWS);

#ifdef _REFLECTIONS_TOON
	float posterizationLevel = lerp(2, 20, ACCESS_PROP_FLOAT(_ToonFactor));
	res = floor(res * posterizationLevel) / posterizationLevel;
#endif

	res *= ACCESS_PROP_FLOAT(_ReflectionsAtten);

	return res;
}
#endif

float3 ShadeSH(float4 normalWS)
{
	float3 res = ShadeSH9(normalWS);
	return res;
}


#define NUM_ADDITIONAL_LIGHTS 4;

#define OBJECT_TO_CLIP_SPACE(v) UnityObjectToClipPos(v.vertex)
#define OBJECT_TO_CLIP_SPACE_FLOAT4(pos) UnityObjectToClipPos(pos)

#endif