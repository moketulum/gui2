#!/bin/bash

# Script de Verificación - OpenBlock GUI para macOS
# Versión: 1.0
# Fecha: 2025

echo "🔍 Verificando instalación de OpenBlock GUI..."
echo "=============================================="

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

# Función para verificar versión mínima
check_version() {
    local command=$1
    local min_version=$2
    local current_version=$3
    
    if [ "$(printf '%s\n' "$min_version" "$current_version" | sort -V | head -n1)" = "$min_version" ]; then
        return 0
    else
        return 1
    fi
}

# Contador de verificaciones
total_checks=0
passed_checks=0
failed_checks=0

# Función para verificar comando
verify_command() {
    local name=$1
    local command=$2
    local min_version=$3
    local get_version=$4
    
    total_checks=$((total_checks + 1))
    
    if command_exists "$command"; then
        if [ -n "$get_version" ]; then
            version=$($get_version 2>/dev/null | head -n1)
            if [ -n "$version" ]; then
                if [ -n "$min_version" ]; then
                    if check_version "$command" "$min_version" "$version"; then
                        print_success "$name: $version ✅"
                        passed_checks=$((passed_checks + 1))
                    else
                        print_warning "$name: $version (mínimo requerido: $min_version) ⚠️"
                        passed_checks=$((passed_checks + 1))
                    fi
                else
                    print_success "$name: $version ✅"
                    passed_checks=$((passed_checks + 1))
                fi
            else
                print_success "$name: Instalado ✅"
                passed_checks=$((passed_checks + 1))
            fi
        else
            print_success "$name: Instalado ✅"
            passed_checks=$((passed_checks + 1))
        fi
    else
        print_error "$name: No instalado ❌"
        failed_checks=$((failed_checks + 1))
    fi
}

echo ""
print_status "Verificando sistema operativo..."

# Verificar macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    macos_version=$(sw_vers -productVersion)
    print_success "macOS: $macos_version ✅"
else
    print_error "Sistema operativo: No es macOS ❌"
    exit 1
fi

echo ""
print_status "Verificando arquitectura del sistema..."
arch=$(uname -m)
if [[ "$arch" == "arm64" ]]; then
    print_success "Arquitectura: Apple Silicon (M1/M2) ✅"
elif [[ "$arch" == "x86_64" ]]; then
    print_success "Arquitectura: Intel x64 ✅"
else
    print_warning "Arquitectura: $arch ⚠️"
fi

echo ""
print_status "Verificando herramientas de desarrollo..."

# Verificar Xcode Command Line Tools
total_checks=$((total_checks + 1))
if xcode-select -p &> /dev/null; then
    clt_path=$(xcode-select -p)
    print_success "Xcode Command Line Tools: $clt_path ✅"
    passed_checks=$((passed_checks + 1))
else
    print_error "Xcode Command Line Tools: No instalado ❌"
    failed_checks=$((failed_checks + 1))
fi

# Verificar compilador C
total_checks=$((total_checks + 1))
if command_exists gcc; then
    gcc_version=$(gcc --version | head -n1)
    print_success "Compilador C: $gcc_version ✅"
    passed_checks=$((passed_checks + 1))
else
    print_error "Compilador C: No instalado ❌"
    failed_checks=$((failed_checks + 1))
fi

echo ""
print_status "Verificando gestores de paquetes..."

# Verificar Homebrew
verify_command "Homebrew" "brew" "3.0" "brew --version"

echo ""
print_status "Verificando runtime de JavaScript..."

# Verificar Node.js
verify_command "Node.js" "node" "16.0" "node --version"

# Verificar npm
verify_command "npm" "npm" "8.0" "npm --version"

echo ""
print_status "Verificando herramientas de desarrollo..."

# Verificar Git
verify_command "Git" "git" "2.30" "git --version"

# Verificar Python
verify_command "Python 3" "python3" "3.8" "python3 --version"

# Verificar pip
verify_command "pip3" "pip3" "20.0" "pip3 --version"

echo ""
print_status "Verificando herramientas de hardware..."

# Verificar Arduino CLI
verify_command "Arduino CLI" "arduino-cli" "0.20" "arduino-cli version"

# Verificar esptool
verify_command "esptool" "esptool.py" "" "esptool.py version"

echo ""
print_status "Verificando editores de código..."

# Verificar VS Code
verify_command "Visual Studio Code" "code" "1.70" "code --version"

echo ""
print_status "Verificando OpenBlock GUI..."

# Verificar si existe el directorio
if [ -d "openblock-gui" ]; then
    print_success "Directorio OpenBlock GUI: Encontrado ✅"
    passed_checks=$((passed_checks + 1))
    
    # Verificar package.json
    if [ -f "openblock-gui/package.json" ]; then
        print_success "package.json: Encontrado ✅"
        passed_checks=$((passed_checks + 1))
        
        # Verificar node_modules
        if [ -d "openblock-gui/node_modules" ]; then
            print_success "node_modules: Instalado ✅"
            passed_checks=$((passed_checks + 1))
        else
            print_warning "node_modules: No instalado ⚠️"
            print_status "Ejecuta: cd openblock-gui && npm install"
        fi
    else
        print_error "package.json: No encontrado ❌"
        failed_checks=$((failed_checks + 1))
    fi
else
    print_warning "Directorio OpenBlock GUI: No encontrado ⚠️"
    print_status "Ejecuta: git clone https://github.com/openblockcc/openblock-gui.git"
    failed_checks=$((failed_checks + 1))
fi

echo ""
print_status "Verificando configuración de Git..."

# Verificar configuración de Git
if git config --global user.name &> /dev/null; then
    git_name=$(git config --global user.name)
    print_success "Git user.name: $git_name ✅"
else
    print_warning "Git user.name: No configurado ⚠️"
    print_status "Ejecuta: git config --global user.name 'Tu Nombre'"
fi

if git config --global user.email &> /dev/null; then
    git_email=$(git config --global user.email)
    print_success "Git user.email: $git_email ✅"
else
    print_warning "Git user.email: No configurado ⚠️"
    print_status "Ejecuta: git config --global user.email 'tu@email.com'"
fi

echo ""
print_status "Verificando memoria y espacio en disco..."

# Verificar memoria
memory_gb=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024)}')
if [ "$memory_gb" -ge 8 ]; then
    print_success "Memoria RAM: ${memory_gb}GB ✅"
else
    print_warning "Memoria RAM: ${memory_gb}GB (mínimo recomendado: 8GB) ⚠️"
fi

# Verificar espacio en disco
disk_space=$(df -h . | awk 'NR==2 {print $4}' | sed 's/Gi//')
if [ -n "$disk_space" ] && [ "$disk_space" -ge 5 ]; then
    print_success "Espacio en disco: ${disk_space}GB disponible ✅"
else
    print_warning "Espacio en disco: ${disk_space}GB (mínimo recomendado: 5GB) ⚠️"
fi

echo ""
echo "=============================================="
echo "📊 RESUMEN DE VERIFICACIÓN"
echo "=============================================="
echo "Total de verificaciones: $total_checks"
echo "Verificaciones exitosas: $passed_checks"
echo "Verificaciones fallidas: $failed_checks"

if [ $failed_checks -eq 0 ]; then
    echo ""
    print_success "¡Todas las verificaciones pasaron! 🎉"
    echo ""
    print_status "Para ejecutar OpenBlock GUI:"
    echo "  cd openblock-gui"
    echo "  npm start"
    echo ""
    print_status "La aplicación estará disponible en:"
    echo "  http://localhost:8601"
else
    echo ""
    print_warning "Algunas verificaciones fallaron ⚠️"
    echo ""
    print_status "Para instalar los componentes faltantes:"
    echo "  ./instalar-openblock-mac.sh"
fi

echo ""
echo "=============================================="
