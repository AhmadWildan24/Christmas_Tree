Shader "Custom/ShaderOrnamen4"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Mode ("Ornamen Mode", Range(0, 3)) = 0.0
        _ColorChangeInterval ("Change Interval (seconds)", Range(0.1, 10.0)) = 0.0
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
        half _Mode;
        fixed4 _ColorVariable;
        half _ColorChangeInterval;
        float _LastColorChangeTime;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Mendapatkan warna dasar dari tekstur
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);

            // Jika _Mode diubah, atur warna berkedip
            if (_Mode == 0.0)
            {
                float time = _Time.y;

                // Memeriksa apakah sudah waktunya mengubah warna
                if (time - _LastColorChangeTime >= _ColorChangeInterval)
                {
                    // Menghitung indeks warna berdasarkan waktu
                    int colorIndex = int(time / _ColorChangeInterval) % 7;

                    // Mengatur warna berdasarkan indeks
                    if (colorIndex == 4)      c.rgb = float3(1.0, 0.0, 0.0); // Merah
                    else if (colorIndex == 5) c.rgb = float3(1.0, 1.0, 0.0); // Kuning
                    else if (colorIndex == 6) c.rgb = float3(0.0, 1.0, 0.0); // Hijau
                    else if (colorIndex == 0) c.rgb = float3(0.0, 0.0, 1.0); // Biru
                    else if (colorIndex == 1) c.rgb = float3(1.0, 0.0, 1.0); // Ungu
                    else if (colorIndex == 2) c.rgb = float3(0.0, 1.0, 1.0); // Cyan
                    else if (colorIndex == 3) c.rgb = float3(1.0, 0.5, 0.0); // Oranye

                    // Memperbarui waktu terakhir perubahan warna
                    _LastColorChangeTime = time;
                }
            }
            else if (_Mode == 1.0)
            {
                float time = _Time.y;

                // Memeriksa apakah sudah waktunya mengubah warna
                if (time - _LastColorChangeTime >= _ColorChangeInterval)
                {
                    // Menghitung indeks warna berdasarkan waktu
                    int colorIndex = int(time / _ColorChangeInterval) % 7;

                    // Mengatur warna berdasarkan indeks
                    if (colorIndex == 2)      c.rgb = float3(1.0, 0.0, 0.0); // Merah
                    else if (colorIndex == 1) c.rgb = float3(1.0, 1.0, 0.0); // Kuning
                    else if (colorIndex == 0) c.rgb = float3(0.0, 1.0, 0.0); // Hijau
                    else if (colorIndex == 6) c.rgb = float3(0.0, 0.0, 1.0); // Biru
                    else if (colorIndex == 5) c.rgb = float3(1.0, 0.0, 1.0); // Ungu
                    else if (colorIndex == 4) c.rgb = float3(0.0, 1.0, 1.0); // Cyan
                    else if (colorIndex == 3) c.rgb = float3(1.0, 0.5, 0.0); // Oranye

                    // Memperbarui waktu terakhir perubahan warna
                    _LastColorChangeTime = time;
                }
            }
            else if (_Mode == 2.0)
            {
                float time = _Time.y;

                // Memeriksa apakah sudah waktunya mengubah warna
                if (time - _LastColorChangeTime >= 0.25)
                {
                    // Menghitung indeks warna berdasarkan waktu
                    int colorIndex = int(time / 0.25) % 7;

                    // Mengatur warna berdasarkan indeks
                    if (colorIndex == 6)      c.rgb = float3(1.0, 0.0, 0.0); // Merah
                    else if (colorIndex == 5) c.rgb = float3(1.0, 1.0, 0.0); // Kuning
                    else if (colorIndex == 4) c.rgb = float3(0.0, 1.0, 0.0); // Hijau
                    else if (colorIndex == 3) c.rgb = float3(0.0, 0.0, 1.0); // Biru
                    else if (colorIndex == 2) c.rgb = float3(1.0, 0.0, 1.0); // Ungu
                    else if (colorIndex == 1) c.rgb = float3(0.0, 1.0, 1.0); // Cyan
                    else if (colorIndex == 0) c.rgb = float3(1.0, 0.5, 0.0); // Oranye

                    // Memperbarui waktu terakhir perubahan warna
                    _LastColorChangeTime = time;
                }
            }
            else if (_Mode == 3.0)
            {
                float time = _Time.y;
                // Menggunakan fungsi sin untuk membuat perubahan warna seiring waktu
                float red = sin(2.0 * time) * 0.5 + 0.5;
                float green = cos(1.5 * time) * 0.5 + 0.5;
                float blue = sin(1.0 * time) * 0.5 + 0.5;
                // Menerapkan nilai-nilai warna ke _ColorVariable
                c.rgb = fixed4(red, green, blue, 1.0);
            }

            // Menerapkan nilai-nilai warna ke _ColorVariable
            _ColorVariable = c;

            // Albedo comes from a texture tinted by color
            o.Albedo = _ColorVariable.rgb;

            // Metallic dan smoothness datang dari properti shader
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
