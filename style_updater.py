import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Colors to Dark Theme
replacements = [
    # Backgrounds
    ("Color(0xFFF1F5F9)", "Color(0xFF000000)"), # Main background -> Pure Black
    ("Colors.white", "Color(0xFF111111)"),      # Cards -> Dark Grey
    ("color: Colors.white", "color: Color(0xFF111111)"),
    ("BackgroundColor: Colors.white", "BackgroundColor: Color(0xFF111111)"),
    
    # Texts
    ("Color(0xFF0F172A)", "Colors.white"),      # Titles -> White
    ("Color(0xFF1E293B)", "Colors.white"),      # Subtitles -> White
    ("Color(0xFF020617)", "Colors.white"),      # Headers -> White
    ("Color(0xFF334155)", "Color(0xFFE4E4E7)"), # Mid text -> Light Grey
    ("Color(0xFF475569)", "Color(0xFFA1A1AA)"),
    ("Color(0xFF64748B)", "Color(0xFFA1A1AA)"), # Muted text -> Zinc 400
    ("Colors.grey.shade500", "Color(0xFFA1A1AA)"),
    ("Colors.grey.shade400", "Color(0xFF71717A)"),
    ("Colors.grey.shade600", "Color(0xFFA1A1AA)"),
    ("Colors.grey.shade300", "Color(0xFF3F3F46)"),
    ("Colors.grey.shade200", "Color(0xFF27272A)"),
    ("Colors.grey.shade100", "Color(0xFF27272A)"),
    ("Colors.grey", "Color(0xFF52525B)"),

    # Primary Accents (Make them Neon/Premium)
    ("Color(0xFF3B82F6)", "Color(0xFF00E5FF)"), # Blue -> Neon Cyan
    ("Color(0xFF1D4ED8)", "Color(0xFF7000FF)"), # Deep Blue -> Deep Neon Purple
    ("Color(0xFF2563EB)", "Color(0xFF00E5FF)"),
    ("Color(0xFF10B981)", "Color(0xFF00FFA3)"), # Emerald -> Neon Spring Green
    ("Color(0xFFF59E0B)", "Color(0xFFFFB000)"), # Amber -> Neon Gold
    ("Color(0xFF8B5CF6)", "Color(0xFFB52BFF)"), # Purple -> Neon Purple
    ("Color(0xFF047857)", "Color(0xFF008A56)"), # Dark Emerald

    # Status Bar
    ("statusBarIconBrightness: Brightness.dark", "statusBarIconBrightness: Brightness.light"),

    # Specific fixes for text on neon backgrounds
    ("color: Colors.white,", "color: Colors.white,"), # Just in case

    # Shadows to be glowing
    ("color: const Color(0xFF0F172A).withOpacity(0.08)", "color: const Color(0xFF00E5FF).withOpacity(0.1)"),
    ("color: const Color(0xFF0F172A).withOpacity(0.04)", "color: Colors.black.withOpacity(0.5)"),
    ("color: const Color(0xFF0F172A).withOpacity(0.05)", "color: Colors.black.withOpacity(0.5)"),
    ("color: const Color(0xFF0F172A).withOpacity(0.03)", "color: Colors.black.withOpacity(0.5)"),
    ("color: const Color(0xFF0F172A).withOpacity(0.1)", "color: Colors.white.withOpacity(0.05)"),
    ("color: const Color(0xFF0F172A).withOpacity(0.15)", "color: Color(0xFF00E5FF).withOpacity(0.15)"),
    ("color: const Color(0xFF0F172A).withOpacity(0.3)", "color: Colors.black.withOpacity(0.6)"),
    ("color: Colors.white.withOpacity(0.95)", "color: Color(0xFF111111).withOpacity(0.7)"), # Nav bar base
    
    # Borders
    ("BorderRadius.circular(24)", "BorderRadius.circular(32)"),
    ("BorderRadius.circular(30)", "BorderRadius.circular(40)"),
]

for old, new in replacements:
    content = content.replace(old, new)

# Add Glassmorphism to Bottom Navigation
nav_pattern = r"(color: Color\(0xFF111111\)\.withOpacity\(0\.7\),\s*// Slight transparency for premium feel\s*borderRadius: BorderRadius\.circular\(\d+\),\s*boxShadow: \[\s*BoxShadow\([^\]]+\),\s*\],\s*\),\s*child: )(Row\()"
nav_replacement = r"\1ClipRRect(borderRadius: BorderRadius.circular(40), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), child: \2"
# Fix the closing of the cliprrect if needed, but it's simpler to just do this:
# Wait, let's just replace the whole BottomAppBar container manually instead of regex to be safe.

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print('Done')
