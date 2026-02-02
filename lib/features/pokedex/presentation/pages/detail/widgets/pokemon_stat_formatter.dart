/// Utilidad para formatear nombres de estadísticas
class PokemonStatFormatter {
  static String formatName(String statName) {
    const Map<String, String> statNames = {
      'hp': 'PS',
      'attack': 'Ataque',
      'defense': 'Defensa',
      'special-attack': 'Atq. Esp.',
      'special-defense': 'Def. Esp.',
      'speed': 'Velocidad',
    };
    return statNames[statName] ?? statName.toUpperCase();
  }
}
