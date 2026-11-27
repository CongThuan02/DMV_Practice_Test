class TopicInfo {
  const TopicInfo(this.id, this.title, this.emoji);

  final String id;
  final String title;
  final String emoji;
}

abstract class TopicCatalog {
  static const _topics = {
    'signs': TopicInfo('signs', 'Road signs', '🚧'),
    'right_of_way': TopicInfo('right_of_way', 'Right of way', '🔀'),
    'lanes': TopicInfo('lanes', 'Lanes, turns and passing', '🛣'),
    'speed': TopicInfo('speed', 'Speed and distance', '⏱'),
    'parking': TopicInfo('parking', 'Parking', '🅿'),
    'alcohol': TopicInfo('alcohol', 'Alcohol and drugs', '🍺'),
    'safe_driving': TopicInfo('safe_driving', 'Safe driving', '🛡'),
    'licenses': TopicInfo('licenses', 'Licenses and rules', '📄'),
  };

  static TopicInfo of(String id) => _topics[id] ?? TopicInfo(id, id, '📘');
}
