using UnityEngine;

public class ChangeMode : MonoBehaviour
{
    public Material material; // Asumsikan material shader Anda terpasang di objek ini

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            // Set properti _Mode ke 0.0 saat tombol 1 ditekan
            material.SetFloat("_Mode", 0.0f);
        }
        else if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            // Set properti _Mode ke 1.0 saat tombol 2 ditekan
            material.SetFloat("_Mode", 1.0f);
        }
        else if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            // Set properti _Mode ke 2.0 saat tombol 3 ditekan
            material.SetFloat("_Mode", 2.0f);
        }
        else if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            // Set properti _Mode ke 3.0 saat tombol 4 ditekan
            material.SetFloat("_Mode", 3.0f);
        }
    }
}
