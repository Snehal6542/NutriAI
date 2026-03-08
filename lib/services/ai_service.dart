class ProteinAIService {
  static String getProteinSuggestion(int consumed, int required) {
    if (consumed >= required) {
      return "Great job! You've reached your protein goal 💪";
    } else {
      int diff = required - consumed;
      return "You're $diff g short. Try adding paneer, eggs or dal.";
    }
  }
}