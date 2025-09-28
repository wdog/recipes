#!/bin/bash
# ~/bin/install-markdown-deps.sh
# Installa tutte le dipendenze per markdown perfetto

echo "🔷 WAYFIRE MARKDOWN OVERLAY - Installazione Completa"
echo "====================================================="

# Colori
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}📦 Aggiornamento repository...${NC}"
sudo apt update

echo -e "${BLUE}🔧 Installazione Qt WebEngine...${NC}"
if sudo apt install -y python3-pyqt5 python3-pyqt5.qtwebengine; then
    echo -e "${GREEN}✅ PyQt5 WebEngine installato${NC}"
    QT_STATUS="✅"
else
    echo -e "${YELLOW}⚠️  Provo PySide2...${NC}"
    if sudo apt install -y python3-pyside2.qtwebengine; then
        echo -e "${GREEN}✅ PySide2 installato${NC}"
        QT_STATUS="✅"
    else
        echo -e "${RED}❌ Errore Qt WebEngine${NC}"
        QT_STATUS="❌"
    fi
fi

echo -e "${BLUE}📝 Installazione librerie Markdown...${NC}"

# Installa python-markdown (raccomandato)
if sudo apt install -y python3-markdown; then
    echo -e "${GREEN}✅ python-markdown installato${NC}"
    MARKDOWN_STATUS="✅ python-markdown"
else
    echo -e "${YELLOW}⚠️  Provo con pip...${NC}"
    if pip3 install --user markdown --break-system-packages; then
        echo -e "${GREEN}✅ python-markdown via pip${NC}"
        MARKDOWN_STATUS="✅ python-markdown (pip)"
    else
        MARKDOWN_STATUS="❌"
    fi
fi

# Installa markdown2 (alternativa)
echo -e "${BLUE}📝 Installazione markdown2...${NC}"
if pip3 install --user markdown2 --break-system-packages; then
    echo -e "${GREEN}✅ markdown2 installato${NC}"
    MARKDOWN2_STATUS="✅"
else
    echo -e "${YELLOW}⚠️  markdown2 non disponibile${NC}"
    MARKDOWN2_STATUS="❌"
fi

# Installa mistune (alternativa veloce)
echo -e "${BLUE}📝 Installazione mistune...${NC}"
if pip3 install --user mistune --break-system-packages; then
    echo -e "${GREEN}✅ mistune installato${NC}"
    MISTUNE_STATUS="✅"
else
    MISTUNE_STATUS="❌"
fi

echo -e "${BLUE}🎨 Installazione Pygments (syntax highlighting)...${NC}"
if sudo apt install -y python3-pygments; then
    echo -e "${GREEN}✅ Pygments installato${NC}"
    PYGMENTS_STATUS="✅"
else
    if pip3 install --user pygments --break-system-packages.; then
        echo -e "${GREEN}✅ Pygments via pip${NC}"
        PYGMENTS_STATUS="✅ (pip)"
    else
        echo -e "${RED}❌ Errore Pygments${NC}"
        PYGMENTS_STATUS="❌"
    fi
fi

echo -e "${BLUE}🔤 Verifica font...${NC}"
if fc-list | grep -q "DejaVu"; then
    echo -e "${GREEN}✅ Font DejaVu disponibili${NC}"
    FONT_STATUS="✅"
else
    echo -e "${YELLOW}📥 Installazione font...${NC}"
    sudo apt install -y fonts-dejavu fonts-dejavu-core fonts-dejavu-extra
    FONT_STATUS="✅ (installati)"
fi

echo ""
echo -e "${GREEN}🎉 INSTALLAZIONE COMPLETATA!${NC}"
echo ""
echo "📋 Riepilogo Dipendenze:"
echo "========================"
echo -e "🖼️  Qt WebEngine:     $QT_STATUS"
echo -e "📝 Python-Markdown:  $MARKDOWN_STATUS"
echo -e "📝 Markdown2:         $MARKDOWN2_STATUS"
echo -e "📝 Mistune:           $MISTUNE_STATUS"
echo -e "🎨 Pygments:          $PYGMENTS_STATUS"
echo -e "🔤 Font DejaVu:       $FONT_STATUS"

echo ""
echo "🧪 Test delle librerie:"
echo "======================="

# Test Python-Markdown
echo -n "📝 python-markdown: "
if python3 -c "import markdown; print('✅ OK')" 2>/dev/null; then
    echo -e "${GREEN}✅ Funzionante${NC}"
    BEST_LIB="python-markdown"
else
    echo -e "${RED}❌ Non disponibile${NC}"
fi

# Test Markdown2
echo -n "📝 markdown2: "
if python3 -c "import markdown2; print('✅ OK')" 2>/dev/null; then
    echo -e "${GREEN}✅ Funzionante${NC}"
    if [ -z "$BEST_LIB" ]; then
        BEST_LIB="markdown2"
    fi
else
    echo -e "${RED}❌ Non disponibile${NC}"
fi

# Test Mistune
echo -n "📝 mistune: "
if python3 -c "import mistune; print('✅ OK')" 2>/dev/null; then
    echo -e "${GREEN}✅ Funzionante${NC}"
    if [ -z "$BEST_LIB" ]; then
        BEST_LIB="mistune"
    fi
else
    echo -e "${RED}❌ Non disponibile${NC}"
fi

# Test Pygments
echo -n "🎨 pygments: "
if python3 -c "import pygments; print('✅ OK')" 2>/dev/null; then
    echo -e "${GREEN}✅ Funzionante${NC}"
    SYNTAX_HL="✅"
else
    echo -e "${RED}❌ Non disponibile${NC}"
    SYNTAX_HL="❌"
fi

# Test Qt
echo -n "🖼️  Qt WebEngine: "
if python3 -c "from PyQt5.QtWebEngineWidgets import QWebEngineView; print('✅ OK')" 2>/dev/null; then
    echo -e "${GREEN}✅ PyQt5 OK${NC}"
    QT_LIB="PyQt5"
elif python3 -c "from PySide2.QtWebEngineWidgets import QWebEngineView; print('✅ OK')" 2>/dev/null; then
    echo -e "${GREEN}✅ PySide2 OK${NC}"
    QT_LIB="PySide2"
else
    echo -e "${RED}❌ Non disponibile${NC}"
    QT_LIB="❌"
fi

echo ""
if [ "$QT_LIB" != "❌" ] && [ -n "$BEST_LIB" ]; then
    echo -e "${GREEN}🚀 TUTTO PRONTO PER MARKDOWN PERFETTO!${NC}"
    echo ""
    echo -e "${BLUE}📊 Configurazione ottimale:${NC}"
    echo "  • Libreria markdown: $BEST_LIB"
    echo "  • Qt WebEngine: $QT_LIB"
    echo "  • Syntax highlighting: $SYNTAX_HL"
    echo ""
    echo -e "${BLUE}🎯 Per testare:${NC}"
    echo "  python3 ~/bin/wayfire-info-markdown.py"
    echo ""
    echo -e "${BLUE}⚙️  Per configurare wayfire.ini:${NC}"
    echo "  command_info = ~/bin/wayfire-info-markdown.py"
else
    echo -e "${YELLOW}⚠️  Installazione parziale${NC}"
    echo ""
    echo "Problemi riscontrati:"
    if [ "$QT_LIB" = "❌" ]; then
        echo "  • Qt WebEngine non disponibile"
        echo "    Soluzione: sudo apt install python3-pyqt5.qtwebengine"
    fi
    if [ -z "$BEST_LIB" ]; then
        echo "  • Nessuna libreria markdown funzionante"
        echo "    Soluzione: pip3 install --user markdown"
    fi
fi

echo ""
echo -e "${BLUE}📋 Features supportate:${NC}"
echo "  ✅ Tabelle markdown"
echo "  ✅ Code blocks con syntax highlighting"
echo "  ✅ Liste e task lists"
echo "  ✅ Blockquotes"
echo "  ✅ Links e formattazione"
echo "  ✅ Emoji e simboli Unicode"
echo "  ✅ CSS styling avanzato"
echo "  ✅ Responsive design"


if [ "$SYNTAX_HL" = "✅" ]; then
    echo "  ✅ Syntax highlighting per:"
    echo "    • Bash/Shell"
    echo "    • PHP (Laravel)"
    echo "    • JavaScript"
    echo "    • Python"
    echo "    • CSS/HTML"
    echo "    • SQL"
fi
