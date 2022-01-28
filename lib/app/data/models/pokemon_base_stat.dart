class PokemonBaseStat {
  final int stat;
  final String name;

  PokemonBaseStat({required this.stat, required this.name});

  factory PokemonBaseStat.fromJson(Map<String, dynamic> json) =>
      PokemonBaseStat(stat: json['base_stat'], name: json['stat']['name']);

  Map<String, dynamic> toJson() => {
        'base_stat': stat,
        'stat': {'name': name}
      };
}
