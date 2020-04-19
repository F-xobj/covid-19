class InternetException implements Exception {
    String reason;

    InternetException(this.reason);

    @override
    String toString() {
        return "InternetException: reason = $reason";
    }
}