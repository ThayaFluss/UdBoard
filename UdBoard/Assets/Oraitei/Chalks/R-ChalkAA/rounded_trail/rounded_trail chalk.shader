/*
Modified rounded trail shader for Black Board.
*/
Shader "Unlit/rounded_trail_chalk"
{
	Properties
	{
		[KeywordEnum(Solid, Texture)] _Mode ("Color Mode", Float) = 0
		_Color ("Solid Color", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}
		[HideInInspector] _Invisible ("Invisible Length", Float) = 0.1
		_Width ("Width", Float) = 0.007
		[HideInInspector] _VRscale("VRscale", Float) = 1.73
		[HideInInspector] [MaterialToggle] _EnableAspect("AspectRatio", Float) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 100
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma multi_compile _MODE_SOLID  _MODE_TEXTURE
			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag
			//#pragma fragment FS_Main
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2g
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct g2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float d : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _Color;
			float _Width;
			float _Invisible;
			float _VRscale;
			float _EnableAspect;
			
			v2g vert (appdata v)
			{
				v2g o;
				o.vertex = v.vertex;
				o.uv = v.uv;
				return o;
			}

			[maxvertexcount(10)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> stream) {
				g2f o;
				if(IN[0].uv.x + IN[2].uv.x > IN[1].uv.x * 2) return;
				float3 p = IN[0].vertex.xyz, v = IN[1].vertex.xyz;
				v -= p;
				
				float4 vp1 = UnityObjectToClipPos(float4(p, 1));
				float4 vp2 = UnityObjectToClipPos(float4(p + v, 1));
				float2 vd = vp1.xy / vp1.w - vp2.xy / vp2.w;
				float aspectRatio = 1;
				if (_EnableAspect == 1){
					aspectRatio = - UNITY_MATRIX_P[0][0] / UNITY_MATRIX_P[1][1];
				}
				vd.x /= aspectRatio;
				o.d = length(vd);
				if(length(vd) < 0.0001) vd = float2(1,0);
				else vd = normalize(vd);
				float2 vn = vd.yx * float2(-1,1);

				//if(abs(UNITY_MATRIX_P[0][2]) < 0.01) size *= 2; 
				float sz = _Width;
				sz *= unity_CameraProjection._m11 / _VRscale;
				vn *= sz;
				vn.x *= aspectRatio;

				
				if(length(v) < _Invisible) {
					o.d = 0;
					o.uv = float2(-1,-1);
					o.vertex = vp1+float4(+vn,0,0);
					stream.Append(o);
					o.uv = float2(-1,1);
					o.vertex = vp1+float4(-vn,0,0);
					stream.Append(o);
					o.uv = float2(1,-1);
					o.vertex = vp2+float4(+vn,0,0);
					stream.Append(o);
					o.uv = float2(1,1);
					o.vertex = vp2+float4(-vn,0,0);
					stream.Append(o);
					stream.RestartStrip();
				}
				
				o.d = 1;
				sz *= 2.0;
				if(IN[1].uv.x >= 0.999999) {
					o.uv = float2(0,1);
					o.vertex = vp2+float4(o.uv*sz*float2(aspectRatio,1),0,0);
					stream.Append(o);
					o.uv = float2(-0.9,-0.5);
					o.vertex = vp2+float4(o.uv*sz*float2(aspectRatio,1),0,0);
					stream.Append(o);
					o.uv = float2(0.9,-0.5);
					o.vertex = vp2+float4(o.uv*sz*float2(aspectRatio,1),0,0);
					stream.Append(o);
					stream.RestartStrip();
				}

				o.uv = float2(0,1);
				o.vertex = vp1+float4(o.uv*sz*float2(aspectRatio,1),0,0);
				stream.Append(o);
				o.uv = float2(-0.9,-0.5);
				o.vertex = vp1+float4(o.uv*sz*float2(aspectRatio,1),0,0);
				stream.Append(o);
				o.uv = float2(0.9,-0.5);
				o.vertex = vp1+float4(o.uv*sz*float2(aspectRatio,1),0,0);
				stream.Append(o);
				stream.RestartStrip();
			}
			
			/*
			fixed4 frag (g2f i) : SV_Target
			{
				float l = length(i.uv);
				clip(- min(i.d - 0.5, l - 0.5));
				return float4(_Color.xyz,1);

			}
			*/


			uniform float4 _MainTex_ST;

			//float4 FS_Main(appdata_full input) : COLOR
			fixed4 frag (g2f input) : SV_Target
			{
				float l = length(input.uv);
				clip(- min(input.d - 0.5, l - 0.5));
				#ifdef _MODE_SOLID
				return _Color;
				#endif


				#ifdef _MODE_TEXTURE
				return tex2D(_MainTex, TRANSFORM_TEX(input.uv, _MainTex));
				#endif
				}



			ENDCG
		}
	}
}
