#ifndef ALLIN13DSHADER_SHADERFEATURES
#define ALLIN13DSHADER_SHADERFEATURES

#pragma shader_feature_local _ALBEDO_VERTEX_COLOR_ON
#pragma shader_feature_local _ALBEDOVERTEXCOLORMODE_MULTIPLY /*_ALBEDOVERTEXCOLORMODE_REPLACE*/

#pragma shader_feature_local _TEXTURE_BLENDING_ON
#pragma shader_feature_local _TEXTUREBLENDINGSOURCE_TEXTURE //_TEXTUREBLENDINGSOURCE_VERTEXCOLOR 
#pragma shader_feature_local _TEXTUREBLENDINGMODE_RGB /*_TEXTUREBLENDINGMODE_BLACKANDWHITE*/

#pragma shader_feature_local _SPHERIZE_NORMALS_ON

#pragma shader_feature_local _EMISSION_ON

#pragma shader_feature_local _SCREEN_SPACE_UV_ON

#pragma shader_feature_local _TRIPLANAR_MAPPING_ON
#pragma shader_feature_local _TRIPLANARNORMALSPACE_LOCAL /*_TRIPLANARNORMALSPACE_WORLD*/

#pragma shader_feature_local _LIGHTMODEL_NONE _LIGHTMODEL_CLASSIC _LIGHTMODEL_TOON _LIGHTMODEL_TOONRAMP _LIGHTMODEL_HALFLAMBERT _LIGHTMODEL_FAKEGI _LIGHTMODEL_FASTLIGHTING
#pragma shader_feature_local _SPECULARMODEL_NONE _SPECULARMODEL_CLASSIC _SPECULARMODEL_TOON _SPECULARMODEL_ANISOTROPIC _SPECULARMODEL_ANISOTROPICTOON
#pragma shader_feature_local _CUSTOM_SHADOW_COLOR_ON

#pragma shader_feature_local _AFFECTED_BY_LIGHTMAPS_ON
#pragma shader_feature_local _LIGHTMAP_COLOR_CORRECTION_ON

#pragma shader_feature_local _CUSTOM_AMBIENT_LIGHT_ON

#pragma shader_feature_local _CAST_SHADOWS_ON

#pragma shader_feature_local _RECEIVE_SHADOWS_ON

#pragma shader_feature_local _RIM_LIGHTING_ON
#pragma shader_feature_local _RIMLIGHTINGSTAGE_BEFORELIGHTING _RIMLIGHTINGSTAGE_BEFORELIGHTINGLAST _RIMLIGHTINGSTAGE_AFTERLIGHTING

#pragma shader_feature_local _GREYSCALE_ON
#pragma shader_feature_local _GREYSCALESTAGE_BEFORELIGHTING /*_GREYSCALESTAGE_AFTERLIGHTING*/

#pragma shader_feature_local _POSTERIZE_ON

#pragma shader_feature_local _NORMAL_MAP_ON
#pragma shader_feature_local _AOMAP_ON
#pragma shader_feature_local _HIGHLIGHTS_ON

#pragma shader_feature_local _USE_CUSTOM_TIME

#pragma shader_feature_local _FOG_ON

#pragma shader_feature_local _MATCAP_ON
#pragma shader_feature_local _MATCAPBLENDMODE_MULTIPLY //_MATCAPBLENDMODE_REPLACE

#pragma shader_feature_local _HEIGHT_GRADIENT_ON
#pragma shader_feature_local _HEIGHTGRADIENTPOSITIONSPACE_WORLD /*_HEIGHTGRADIENTPOSITIONSPACE_LOCAL*/

#pragma shader_feature_local _INTERSECTION_GLOW_ON

#pragma shader_feature_local _DEPTH_COLORING_ON

#pragma shader_feature_local _SUBSURFACE_SCATTERING_ON

#pragma shader_feature_local _ALPHA_CUTOFF_ON

#pragma shader_feature_local _COLOR_RAMP_ON
#pragma shader_feature_local _COLORRAMPLIGHTINGSTAGE_BEFORELIGHTING //_COLORRAMPLIGHTINGSTAGE_AFTERLIGHTING

#pragma shader_feature_local _HIT_ON

#pragma shader_feature_local _FADE_ON
#pragma shader_feature_local _FADE_BURN_ON

#pragma shader_feature_local _ALPHA_ROUND_ON

#pragma shader_feature_local _FADE_BY_CAM_DISTANCE_ON
#pragma shader_feature_local _FADE_BY_CAM_DISTANCE_NEAR_FADE

#pragma shader_feature_local _DITHER_ON

#pragma shader_feature_local _SHADINGMODEL_BASIC _SHADINGMODEL_PBR
#pragma shader_feature_local _METALLIC_MAP_ON
#pragma shader_feature_local _GLOSS_MAP_ON

#pragma shader_feature_local _CONTRAST_BRIGHTNESS_ON

#pragma shader_feature_local _VERTEX_SHAKE_ON
#pragma shader_feature_local _VERTEX_DISTORTION_ON

#pragma shader_feature_local _WIND_ON
#pragma shader_feature_local _USE_WIND_VERTICAL_MASK

#pragma shader_feature_local _VERTEX_INFLATE_ON
#pragma shader_feature_local _VOXELIZE_ON
#pragma shader_feature_local _GLITCH_ON
#pragma shader_feature_local _RECALCULATE_NORMALS_ON

#pragma shader_feature_local _HUE_SHIFT_ON
#pragma shader_feature_local _HOLOGRAM_ON

#pragma shader_feature_local _INTERSECTION_FADE_ON

#pragma shader_feature_local _SCROLL_TEXTURE_ON

#pragma shader_feature_local _WAVE_UV_ON

#pragma shader_feature_local _HAND_DRAWN_ON

#pragma shader_feature_local _UV_DISTORTION_ON

#pragma shader_feature_local _PIXELATE_ON

#pragma shader_feature_local _STOCHASTIC_SAMPLING_ON

#pragma shader_feature_local _OUTLINETYPE_NONE _OUTLINETYPE_SIMPLE _OUTLINETYPE_CONSTANT _OUTLINETYPE_FADEWITHDISTANCE

#endif //ALLIN13DSHADER_SHADERFEATURES