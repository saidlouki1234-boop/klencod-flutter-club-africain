
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class FootballBall : MonoBehaviour
{
    private Rigidbody rb;

    void Awake()
    {
        rb = GetComponent<Rigidbody>();
        rb.collisionDetectionMode =
            CollisionDetectionMode.ContinuousDynamic;
    }

    public void Kick(Vector3 direction, float force)
    {
        rb.AddForce(direction * force, ForceMode.Impulse);
    }

    public void ResetBall(Vector3 position)
    {
        rb.linearVelocity = Vector3.zero;
        rb.angularVelocity = Vector3.zero;
        rb.position = position;
    }
}
