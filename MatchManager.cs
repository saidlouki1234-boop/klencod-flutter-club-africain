
using UnityEngine;
using TMPro;

public class MatchManager : MonoBehaviour
{
    public TMP_Text scoreText;
    public TMP_Text timerText;

    public int homeScore;
    public int awayScore;
    public float matchDuration = 180f;

    private float timeRemaining;
    private bool running = true;

    void Start()
    {
        timeRemaining = matchDuration;
        UpdateUI();
    }

    void Update()
    {
        if (!running) return;

        timeRemaining -= Time.deltaTime;

        if (timeRemaining <= 0f)
        {
            timeRemaining = 0f;
            running = false;
        }

        UpdateUI();
    }

    public void HomeGoal()
    {
        if (!running) return;
        homeScore++;
        UpdateUI();
    }

    public void AwayGoal()
    {
        if (!running) return;
        awayScore++;
        UpdateUI();
    }

    void UpdateUI()
    {
        if (scoreText != null)
            scoreText.text = homeScore + " - " + awayScore;

        if (timerText != null)
        {
            int seconds = Mathf.CeilToInt(timeRemaining);
            timerText.text =
                (seconds / 60).ToString("00") + ":" +
                (seconds % 60).ToString("00");
        }
    }
}
