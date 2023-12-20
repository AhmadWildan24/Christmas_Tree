using UnityEngine;

public class ShaderController : MonoBehaviour
{
    public Material material; // Asumsikan material shader Anda terpasang di objek ini

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            // Set properti _Mode ke 1.0 saat tombol 1 ditekan
            material.SetFloat("_Mode", 1.0f);
        }
    }
}
