Shader "Custom/BarberPoleShader"
{
    Properties
    {
        _ColorPrimary ("Primary Color", Color) = (1,1,1,1)
        _ColorSecondary ("Secondary Color", Color) = (1,1,1,1)
        _COlorTriple ("Triple Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _RotationSpeed ("Rotation Speed", Range(0, 10)) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _ColorPrimary;
        fixed4 _ColorSecondary;
        fixed4 _COlorTriple;
        half _RotationSpeed;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float angle = _Time.y * _RotationSpeed * 360.0;
            float rotation = radians(angle);

            float2 rotatedUV = mul(float2x2(cos(rotation), -sin(rotation), sin(rotation), cos(rotation)), IN.uv_MainTex - 0.5) + 0.5;

            fixed4 currentColor1 = (rotatedUV.x > 0.5) ? _COlorTriple : _ColorPrimary;
            fixed4 currentColor2 = (rotatedUV.x > 0.5) ? _ColorPrimary : _COlorTriple;
            fixed4 c = tex2D (_MainTex, rotatedUV) * currentColor2;
            o.Albedo = c.xyz;

            if (abs(IN.worldPos.y + 0.5 - rotatedUV.y) < 0.05)
            {
                o.Albedo = _ColorSecondary;
            }
            if (abs(IN.worldPos.y + 1 - rotatedUV.y) < 0.5)
            {
                o.Albedo = currentColor1;
            }

            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
