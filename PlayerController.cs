
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class PlayerController : MonoBehaviour
{
    public float moveSpeed = 6f;
    public float rotationSpeed = 12f;
    public float kickForce = 8f;
    public float kickDistance = 2f;

    private Rigidbody rb;
    private Vector2 input;
    private FootballBall ball;

    void Awake()
    {
        rb = GetComponent<Rigidbody>();
        rb.constraints = RigidbodyConstraints.FreezeRotationX |
                         RigidbodyConstraints.FreezeRotationZ;
        ball = FindFirstObjectByType<FootballBall>();
    }

    // يمكن ربط هذه الدالة بعصا تحكم افتراضية لاحقاً.
    public void SetMoveInput(Vector2 value)
    {
        input = Vector2.ClampMagnitude(value, 1f);
    }

    void Update()
    {
        // تحكم مبدئي بلوحة المفاتيح عند الاختبار على الكمبيوتر.
        input = new Vector2(
            Input.GetAxisRaw("Horizontal"),
            Input.GetAxisRaw("Vertical")
        );

        if (Input.GetKeyDown(KeyCode.Space))
            Shoot();
    }

    void FixedUpdate()
    {
        Vector3 direction = new Vector3(input.x, 0f, input.y);
        Vector3 nextPosition =
            rb.position + direction * moveSpeed * Time.fixedDeltaTime;

        rb.MovePosition(nextPosition);

        if (direction.sqrMagnitude > 0.01f)
        {
            Quaternion target = Quaternion.LookRotation(direction);
            rb.MoveRotation(Quaternion.Slerp(
                rb.rotation, target,
                rotationSpeed * Time.fixedDeltaTime
            ));
        }
    }

    public void Shoot()
    {
        if (ball == null) return;

        Vector3 toBall = ball.transform.position - transform.position;
        if (toBall.magnitude > kickDistance) return;

        Vector3 direction = transform.forward + Vector3.up * 0.12f;
        ball.Kick(direction.normalized, kickForce);
    }
}
