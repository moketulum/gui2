#!/bin/bash

# Script de Instalación Automática - OpenBlock GUI para macOS
# Versión: 1.0
# Fecha: 2025

set -e  # Salir si hay algún error

echo "🚀 Instalando OpenBlock GUI para macOS..."
echo "=========================================="

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para instalar con Homebrew
install_with_brew() {
    local package=$1
    local description=$2
    
    if command_exists "$package"; then
        print_success "$description ya está instalado"
    else
        print_status "Instalando $description..."
        brew install "$package"
        print_success "$description instalado correctamente"
    fi
}

# Función para instalar cask con Homebrew
install_cask_with_brew() {
    local package=$1
    local description=$2
    
    if command_exists "$package"; then
        print_success "$description ya está instalado"
    else
        print_status "Instalando $description..."
        brew install --cask "$package"
        print_success "$description instalado correctamente"
    fi
}

# Verificar sistema operativo
print_status "Verificando sistema operativo..."
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Este script es solo para macOS"
    exit 1
fi

# Verificar versión de macOS
macos_version=$(sw_vers -productVersion)
print_success "macOS $macos_version detectado"

# PASO 1: Instalar Xcode Command Line Tools
print_status "PASO 1: Instalando Xcode Command Line Tools..."
if xcode-select -p &> /dev/null; then
    print_success "Xcode Command Line Tools ya están instalados"
else
    print_status "Instalando Xcode Command Line Tools..."
    xcode-select --install
    print_warning "Esperando a que se complete la instalación..."
    print_warning "Por favor, haz clic en 'Install' en la ventana que apareció"
    print_warning "Presiona Enter cuando hayas completado la instalación..."
    read -r
fi

# Verificar instalación de Command Line Tools
if xcode-select -p &> /dev/null; then
    print_success "Xcode Command Line Tools instalados correctamente"
else
    print_error "Error: Xcode Command Line Tools no se instalaron correctamente"
    exit 1
fi

# PASO 2: Instalar Homebrew
print_status "PASO 2: Instalando Homebrew..."
if command_exists brew; then
    print_success "Homebrew ya está instalado"
    print_status "Actualizando Homebrew..."
    brew update
else
    print_status "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Agregar Homebrew al PATH
    if [[ -f ~/.zshrc ]]; then
        if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zshrc; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        fi
    else
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    fi
    
    # Cargar Homebrew en la sesión actual
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
    print_success "Homebrew instalado correctamente"
fi

# PASO 3: Instalar Node.js
print_status "PASO 3: Instalando Node.js..."
if command_exists node; then
    print_success "Node.js ya está instalado: $(node --version)"
else
    install_with_brew "node" "Node.js"
fi

# Verificar npm
if command_exists npm; then
    print_success "npm instalado: $(npm --version)"
else
    print_error "Error: npm no se instaló correctamente"
    exit 1
fi

# PASO 4: Instalar Git
print_status "PASO 4: Instalando Git..."
if command_exists git; then
    print_success "Git ya está instalado: $(git --version)"
else
    install_with_brew "git" "Git"
fi

# Configurar Git (opcional)
print_status "Configurando Git..."
if ! git config --global user.name &> /dev/null; then
    print_warning "Configurando Git con valores por defecto..."
    git config --global user.name "OpenBlock User"
    git config --global user.email "user@openblock.local"
    git config --global core.editor "code --wait"
    print_success "Git configurado con valores por defecto"
fi

# PASO 5: Instalar Python 3
print_status "PASO 5: Instalando Python 3..."
if command_exists python3; then
    print_success "Python 3 ya está instalado: $(python3 --version)"
else
    install_with_brew "python@3.11" "Python 3.11"
fi

# Instalar herramientas Python para hardware
print_status "Instalando herramientas Python para hardware..."
pip3 install --upgrade pip
pip3 install esptool pyserial
print_success "Herramientas Python instaladas"

# PASO 6: Instalar Arduino CLI
print_status "PASO 6: Instalando Arduino CLI..."
if command_exists arduino-cli; then
    print_success "Arduino CLI ya está instalado: $(arduino-cli version)"
else
    install_with_brew "arduino-cli" "Arduino CLI"
fi

# Configurar Arduino CLI
print_status "Configurando Arduino CLI..."
arduino-cli config init
arduino-cli core install arduino:avr
arduino-cli core install esp32:esp32
print_success "Arduino CLI configurado"

# PASO 7: Instalar Visual Studio Code
print_status "PASO 7: Instalando Visual Studio Code..."
if command_exists code; then
    print_success "VS Code ya está instalado: $(code --version | head -n1)"
else
    install_cask_with_brew "visual-studio-code" "Visual Studio Code"
fi

# Instalar extensiones útiles
print_status "Instalando extensiones de VS Code..."
code --install-extension ms-python.python --force
code --install-extension ms-vscode.cpptools --force
code --install-extension ms-vscode.arduino --force
print_success "Extensiones de VS Code instaladas"

# PASO 8: Clonar e instalar OpenBlock GUI
print_status "PASO 8: Instalando OpenBlock GUI..."

if [ -d "openblock-gui" ]; then
    print_warning "El directorio openblock-gui ya existe"
    print_status "Actualizando repositorio..."
    cd openblock-gui
    git pull origin main
else
    print_status "Clonando repositorio de OpenBlock GUI..."
    git clone https://github.com/openblockcc/openblock-gui.git
    cd openblock-gui
fi

# Instalar dependencias
print_status "Instalando dependencias de OpenBlock GUI..."
npm install
print_success "Dependencias instaladas correctamente"

# Crear archivo de configuración
print_status "Creando archivo de configuración..."
cat > .env << EOF
NODE_ENV=development
PORT=8601
STATIC_PATH=/static
EOF
print_success "Archivo de configuración creado"

# PASO 9: Verificación final
print_status "PASO 9: Verificación final..."

echo ""
echo "=========================================="
echo "🔍 VERIFICACIÓN DE INSTALACIÓN"
echo "=========================================="

# Verificar Node.js
if command_exists node; then
    echo "✅ Node.js: $(node --version)"
else
    echo "❌ Node.js: No instalado"
fi

# Verificar npm
if command_exists npm; then
    echo "✅ npm: $(npm --version)"
else
    echo "❌ npm: No instalado"
fi

# Verificar Git
if command_exists git; then
    echo "✅ Git: $(git --version)"
else
    echo "❌ Git: No instalado"
fi

# Verificar Python
if command_exists python3; then
    echo "✅ Python: $(python3 --version)"
else
    echo "❌ Python: No instalado"
fi

# Verificar Arduino CLI
if command_exists arduino-cli; then
    echo "✅ Arduino CLI: $(arduino-cli version)"
else
    echo "❌ Arduino CLI: No instalado"
fi

# Verificar VS Code
if command_exists code; then
    echo "✅ VS Code: $(code --version | head -n1)"
else
    echo "❌ VS Code: No instalado"
fi

# Verificar Homebrew
if command_exists brew; then
    echo "✅ Homebrew: $(brew --version | head -n1)"
else
    echo "❌ Homebrew: No instalado"
fi

echo ""
echo "=========================================="
echo "🎉 INSTALACIÓN COMPLETADA"
echo "=========================================="
echo ""
echo "Para ejecutar OpenBlock GUI:"
echo "  cd openblock-gui"
echo "  npm start"
echo ""
echo "La aplicación estará disponible en:"
echo "  http://localhost:8601"
echo ""
echo "¡Disfruta programando con OpenBlock GUI! 🚀"
echo ""
