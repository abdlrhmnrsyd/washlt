import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    text = f.read()

# Fix 'const Colors.white' to just 'Colors.white' for parameters where 'const' keyword is syntactically invalid
text = text.replace('const Colors.white', 'Colors.white')

# Ensure color = Colors.white is handled everywhere 
text = text.replace('Color color = Colors.white,', 'Color color = Colors.white,') # Already valid!

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(text)

print('Syntax fixes applied')
