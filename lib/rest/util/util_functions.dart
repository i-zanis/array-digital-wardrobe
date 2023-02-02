
bool isStale(DateTime lastFetched, Duration timeToLive) {
  return lastFetched.add(timeToLive).isBefore(DateTime.now());
}

