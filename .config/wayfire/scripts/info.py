#!/usr/bin/env python3
# ~/bin/wayfire-info-md-simple.py
# Overlay markdown semplificato senza WebEngine (più stabile)

import sys
import os
import signal
from pathlib import Path
import re

try:
    from PyQt5.QtWidgets import *
    from PyQt5.QtCore import *
    from PyQt5.QtGui import *
    QT_OK = True
except ImportError:
    try:
        from PySide2.QtWidgets import *
        from PySide2.QtCore import *
        from PySide2.QtGui import *
        QT_OK = True
    except ImportError:
        QT_OK = False

# Markdown libs
try:
    import markdown
    MD_LIB = "markdown"
except ImportError:
    try:
        import markdown2
        MD_LIB = "markdown2"
    except ImportError:
        MD_LIB = None

class SimpleMarkdownOverlay:
    def __init__(self):
        self.info_file = Path.home() / ".config/wayfire/scripts/info.md"
        self.lock_file = Path("/tmp/wayfire_md_simple.lock")

    def create_info_if_needed(self):
        if not self.info_file.exists():
            content = '''# 🔷 Wayfire Shortcuts - Debian 13

## 📋 Shortcuts Essenziali

| Combinazione | Azione | App |
|-------------|--------|-----|
| `Alt + D` | **Launcher** | fuzzel |
| `Alt + Enter` | **Terminale** | alacritty |
| `Ctrl + Alt + L` | **Lock screen** | swaylock |
| `Alt + Tab` | **Switch window** | - |
| `Alt + F` | **Maximize** | - |
| `Ctrl + I` | ***Toggle overlay*** | questo! |

## 🏢 Workspace

- **Alt + 1-9** → Vai a workspace specifico
- **Alt + Ctrl + ←→** → Naviga orizzontalmente
- **Shift + Alt + 1-9** → Sposta finestra E vai

## 🎯 Grid Layout

Prefisso `Super` + tastierino numerico:

```
KP7  KP8  KP9     Top-L    Top    Top-R
KP4  KP5  KP6  =  Left   Center  Right
KP1  KP2  KP3     Bot-L   Bottom  Bot-R
```

## 💻 Sistema

- **OS**: Debian 13 Testing
- **WM**: Wayfire
- **Dev**: Laravel + FilamentPHP

---

> Premi `Q`, `ESC` o `Ctrl+I` per chiudere
'''
            self.info_file.parent.mkdir(parents=True, exist_ok=True)
            self.info_file.write_text(content)

    def parse_markdown_to_rich_text(self, markdown_text):
        """Converte markdown in QTextDocument HTML"""
        if MD_LIB == "markdown":
            import markdown
            md = markdown.Markdown(extensions=['tables', 'fenced_code'])
            html = md.convert(markdown_text)
        elif MD_LIB == "markdown2":
            import markdown2
            html = markdown2.markdown(markdown_text, extras=['tables', 'fenced-code-blocks'])
        else:
            # Fallback manuale
            html = self.manual_markdown_parse(markdown_text)

        # Aggiungi CSS inline per QTextBrowser
        styled_html = f"""
        <style>
        body {{
            background-color: #1a1a1a;
            color: #e0e0e0;
            font-family: 'DejaVu Sans';
            font-size: 14px;
            line-height: 1.5;
        }}
        h1 {{
            color: #99c1f1;
            border-bottom: 2px solid #99c1f1;
            padding-bottom: 5px;
        }}
        h2 {{
            color: #89ddff;
            border-bottom: 1px solid #89ddff;
            padding-bottom: 3px;
        }}
        h3 {{ color: #ffa348; }}
        table {{
            border-collapse: collapse;
            width: 100%;
            margin: 10px 0;
            background-color: #2a2a2a;
        }}
        th {{
            background-color: #99c1f1;
            color: #1a1a1a;
            padding: 8px;
            font-weight: bold;
        }}
        td {{
            border: 1px solid #4a4a4a;
            color: #f0f0f0;
            padding: 6px 8px;
        }}
        tr:nth-child(even) {{ background-color: #2d2d2d; }}
        code {{
            background-color: #2a2a2a;
            color: #a5e3a0;
            padding: 2px 4px;
            font-family: 'DejaVu Sans Mono';
        }}
        pre {{
            background-color: #2a2a2a;
            border: 1px solid #4a4a4a;
            padding: 10px;
            color: #99c1f1;
            font-family: 'DejaVu Sans Mono';
        }}
        strong {{ color: #ffa348; }}
        em {{ color: #89ddff; }}
        blockquote {{
            border-left: 4px solid #89ddff;
            margin: 10px 0;
            padding: 10px 15px;
            background-color: #252525;
            color: #89ddff;
        }}
        ul, ol {{ margin-left: 20px; }}
        li {{ color: #f0f0f0; margin: 3px 0; }}
        hr {{
            border: none;
            height: 2px;
            background: #99c1f1;
            margin: 15px 0;
        }}
        </style>
        {html}
        """
        return styled_html

    def manual_markdown_parse(self, text):
        """Parsing markdown manuale per fallback"""
        lines = text.split('\n')
        html_lines = []
        in_code_block = False
        in_table = False

        for line in lines:
            if line.strip().startswith('```'):
                if in_code_block:
                    html_lines.append('</pre>')
                    in_code_block = False
                else:
                    html_lines.append('<pre>')
                    in_code_block = True
                continue

            if in_code_block:
                html_lines.append(line)
                continue

            # Headers
            if line.startswith('# '):
                html_lines.append(f'<h1>{line[2:]}</h1>')
            elif line.startswith('## '):
                html_lines.append(f'<h2>{line[3:]}</h2>')
            elif line.startswith('### '):
                html_lines.append(f'<h3>{line[4:]}</h3>')

            # Tables
            elif '|' in line and line.strip():
                if not in_table:
                    html_lines.append('<table>')
                    in_table = True

                if line.strip().startswith('|---'):
                    continue

                cells = [cell.strip() for cell in line.split('|')[1:-1]]
                if line.count('**') > 0 or line.count('Combinazione') > 0:
                    # Header row
                    html_lines.append('<tr>')
                    for cell in cells:
                        clean_cell = cell.replace('**', '').replace('`', '')
                        html_lines.append(f'<th>{clean_cell}</th>')
                    html_lines.append('</tr>')
                else:
                    # Data row
                    html_lines.append('<tr>')
                    for cell in cells:
                        clean_cell = cell.replace('**', '').replace('`', '')
                        html_lines.append(f'<td>{clean_cell}</td>')
                    html_lines.append('</tr>')

            # Lists
            elif line.startswith('- '):
                if not html_lines or not html_lines[-1].startswith('<li>'):
                    html_lines.append('<ul>')
                content = line[2:].replace('**', '<strong>').replace('**', '</strong>')
                content = content.replace('`', '<code>').replace('`', '</code>')
                html_lines.append(f'<li>{content}</li>')

            # Blockquotes
            elif line.startswith('> '):
                html_lines.append(f'<blockquote>{line[2:]}</blockquote>')

            # Horizontal rules
            elif line.strip() in ['---', '***']:
                if in_table:
                    html_lines.append('</table>')
                    in_table = False
                html_lines.append('<hr>')

            # Regular paragraphs
            elif line.strip():
                if in_table:
                    html_lines.append('</table>')
                    in_table = False

                # Close any open lists
                if html_lines and html_lines[-1].startswith('<li>'):
                    html_lines.append('</ul>')

                content = line.replace('**', '<strong>').replace('**', '</strong>')
                content = content.replace('`', '<code>').replace('`', '</code>')
                html_lines.append(f'<p>{content}</p>')

            else:
                if in_table:
                    html_lines.append('</table>')
                    in_table = False
                html_lines.append('<br>')

        # Chiudi tag aperti
        if in_table:
            html_lines.append('</table>')
        if html_lines and html_lines[-1].startswith('<li>'):
            html_lines.append('</ul>')

        return '\n'.join(html_lines)

    def toggle_check(self):
        if self.lock_file.exists():
            try:
                pid = int(self.lock_file.read_text().strip())
                os.kill(pid, signal.SIGTERM)
                self.lock_file.unlink()
                return False
            except:
                self.lock_file.unlink(missing_ok=True)

        self.lock_file.write_text(str(os.getpid()))
        return True

    def run_overlay(self):
        if not QT_OK:
            print("❌ Qt non disponibile!")
            return

        app = QApplication(sys.argv)

        # Finestra principale
        window = QWidget()
        window.setWindowTitle("Wayfire Markdown Info")
        window.setGeometry(100, 60, 800, 650)
        window.setWindowFlags(Qt.WindowStaysOnTopHint | Qt.Tool)

        # Layout
        layout = QVBoxLayout()
        window.setLayout(layout)

        # Header
        header_layout = QHBoxLayout()
        title = QLabel("🔷 WAYFIRE MARKDOWN OVERLAY")
        title.setStyleSheet("""
            color: #99c1f1;
            font-size: 18px;
            font-weight: bold;
            background-color: #1a1a1a;
            padding: 10px;
        """)
        header_layout.addWidget(title)

        close_btn = QPushButton("✕")
        close_btn.setStyleSheet("""
            background-color: #e01b24;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            padding: 8px;
            max-width: 40px;
            max-height: 30px;
        """)
        close_btn.clicked.connect(app.quit)
        header_layout.addWidget(close_btn)

        layout.addLayout(header_layout)

        # QTextBrowser per HTML rendering (più stabile di WebEngine)
        text_browser = QTextBrowser()
        text_browser.setStyleSheet("""
            QTextBrowser {
                background-color: #1a1a1a;
                border: 1px solid #4a4a4a;
                border-radius: 6px;
                padding: 10px;
                font-size: 14px;
            }
        """)

        # Carica contenuto markdown
        try:
            markdown_content = self.info_file.read_text()
            html_content = self.parse_markdown_to_rich_text(markdown_content)
            text_browser.setHtml(html_content)
        except:
            error_html = "<h1 style='color: #e01b24;'>❌ Errore</h1><p>File info.md non trovato!</p>"
            text_browser.setHtml(error_html)

        layout.addWidget(text_browser)

        # Footer
        footer = QLabel("Premi Q, ESC o Ctrl+I per chiudere")
        footer.setStyleSheet("""
            color: #89ddff;
            font-size: 12px;
            padding: 8px;
            background-color: #1a1a1a;
        """)
        footer.setAlignment(Qt.AlignCenter)
        layout.addWidget(footer)

        # Stile finestra
        window.setStyleSheet("""
            QWidget {
                background-color: #1a1a1a;
                border: 2px solid #99c1f1;
                border-radius: 8px;
            }
        """)

        # Eventi tastiera
        def keypress(event):
            key = event.key()
            if (key == Qt.Key_Q or
                key == Qt.Key_Escape or
                (key == Qt.Key_I and event.modifiers() & Qt.ControlModifier)):
                app.quit()

        window.keyPressEvent = keypress

        # Auto-close
        timer = QTimer()
        timer.timeout.connect(app.quit)
        timer.start(30000)

        # Cleanup
        def cleanup():
            self.lock_file.unlink(missing_ok=True)
        app.aboutToQuit.connect(cleanup)

        # Mostra
        window.show()
        window.setFocus()

        return app.exec_()

    def run(self):
        signal.signal(signal.SIGTERM, lambda s, f: sys.exit(0))

        self.create_info_if_needed()

        if not self.toggle_check():
            return

        print(f"📚 Libreria Markdown: {MD_LIB or 'Fallback manuale'}")

        try:
            self.run_overlay()
        except KeyboardInterrupt:
            pass
        finally:
            self.lock_file.unlink(missing_ok=True)

def main():
    overlay = SimpleMarkdownOverlay()
    overlay.run()

if __name__ == "__main__":
    main()
