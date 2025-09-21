# Guía Completa de Instalación - OpenBlock GUI para macOS

## 📋 Lista de Software Requerido

### **Versiones Recomendadas y Mínimas**

| Software | Versión Mínima | Versión Recomendada | Tamaño | Obligatorio |
|----------|----------------|-------------------|--------|-------------|
| macOS | 10.15 (Catalina) | 13.0+ (Ventura) | - | ✅ |
| Xcode Command Line Tools | 12.0+ | Última | ~500MB | ✅ |
| Homebrew | 3.0+ | 4.0+ | ~50MB | ✅ |
| Node.js | 16.x | 18.x LTS | ~100MB | ✅ |
| Git | 2.30+ | 3.0+ | ~50MB | ✅ |
| Python 3 | 3.8+ | 3.11+ | ~100MB | 🔧 |
| Arduino CLI | 0.20+ | 0.32+ | ~50MB | 🔧 |
| VS Code | 1.70+ | 1.80+ | ~300MB | 🔧 |

**Leyenda**: ✅ Obligatorio | 🔧 Recomendado para hardware

---

## 🚀 Instalación Paso a Paso

### **PASO 1: Verificar Sistema**

```bash
# Verificar versión de macOS
sw_vers

# Verificar arquitectura (Intel vs Apple Silicon)
uname -m
# Debería mostrar: x86_64 (Intel) o arm64 (Apple Silicon)
```

**Requisitos del sistema:**
- **macOS**: 10.15+ (Catalina o superior)
- **RAM**: 8GB mínimo, 16GB recomendado
- **Disco**: 5GB de espacio libre
- **Procesador**: Intel x64 o Apple Silicon (M1/M2)

---

### **PASO 2: Instalar Xcode Command Line Tools**

```bash
# Instalar Command Line Tools (NO Xcode completo)
xcode-select --install

# Esperar a que aparezca la ventana de instalación
# Hacer clic en "Install" y esperar (5-10 minutos)

# Verificar instalación
xcode-select -p
# Debería mostrar: /Library/Developer/CommandLineTools

# Verificar compilador C
gcc --version
# Debería mostrar: Apple clang version...
```

**⏱️ Tiempo estimado**: 5-10 minutos  
**📦 Tamaño**: ~500MB  
**⚠️ Importante**: NO instales Xcode completo (15+ GB), solo Command Line Tools

---

### **PASO 3: Instalar Homebrew**

```bash
# Instalar Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Agregar Homebrew al PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc

# Verificar instalación
brew --version
# Debería mostrar: Homebrew 4.x.x

# Actualizar Homebrew
brew update
```

**⏱️ Tiempo estimado**: 2-3 minutos  
**📦 Tamaño**: ~50MB  
**🔧 Propósito**: Gestor de paquetes para macOS

---

### **PASO 4: Instalar Node.js**

```bash
# Opción A: Instalar Node.js directamente
brew install node

# Opción B: Instalar nvm (recomendado para gestión de versiones)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.zshrc

# Instalar Node.js LTS con nvm
nvm install --lts
nvm use --lts
nvm alias default lts

# Verificar instalación
node --version  # Debería mostrar: v18.x.x o superior
npm --version   # Debería mostrar: 9.x.x o superior
```

**⏱️ Tiempo estimado**: 2-3 minutos  
**📦 Tamaño**: ~100MB  
**🔧 Propósito**: Runtime de JavaScript, npm

---

### **PASO 5: Instalar Git**

```bash
# Instalar Git
brew install git

# Configurar Git (reemplazar con tus datos)
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Configurar editor por defecto
git config --global core.editor "code --wait"

# Verificar instalación
git --version
# Debería mostrar: git version 2.40.x o superior
```

**⏱️ Tiempo estimado**: 1-2 minutos  
**📦 Tamaño**: ~50MB  
**🔧 Propósito**: Control de versiones

---

### **PASO 6: Instalar Python 3 (Para Hardware)**

```bash
# Instalar Python 3
brew install python@3.11

# Verificar instalación
python3 --version  # Debería mostrar: Python 3.11.x
pip3 --version     # Debería mostrar: pip 23.x.x

# Instalar herramientas adicionales para hardware
pip3 install esptool pyserial

# Verificar herramientas
esptool.py version
```

**⏱️ Tiempo estimado**: 3-5 minutos  
**📦 Tamaño**: ~100MB  
**🔧 Propósito**: Compilación de código Python/MicroPython

---

### **PASO 7: Instalar Arduino CLI (Para Hardware)**

```bash
# Instalar Arduino CLI
brew install arduino-cli

# Configurar Arduino CLI
arduino-cli config init

# Instalar cores de Arduino
arduino-cli core install arduino:avr
arduino-cli core install esp32:esp32

# Verificar instalación
arduino-cli version
# Debería mostrar: Arduino CLI 0.32.x o superior

# Listar placas disponibles
arduino-cli board listall
```

**⏱️ Tiempo estimado**: 5-10 minutos  
**📦 Tamaño**: ~50MB  
**🔧 Propósito**: Compilación y carga de código Arduino

---

### **PASO 8: Instalar Visual Studio Code (Recomendado)**

```bash
# Instalar VS Code
brew install --cask visual-studio-code

# Instalar extensiones útiles
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.arduino
code --install-extension ms-vscode.vscode-json

# Verificar instalación
code --version
# Debería mostrar: 1.80.x o superior
```

**⏱️ Tiempo estimado**: 2-3 minutos  
**📦 Tamaño**: ~300MB  
**🔧 Propósito**: Editor de código, debugging

---

### **PASO 9: Instalar OpenBlock GUI**

```bash
# Clonar repositorio
git clone https://github.com/openblockcc/openblock-gui.git
cd openblock-gui

# Instalar dependencias
npm install

# Verificar instalación
npm list --depth=0
```

**⏱️ Tiempo estimado**: 5-10 minutos  
**📦 Tamaño**: ~200MB  
**🔧 Propósito**: Aplicación principal

---

### **PASO 10: Configurar y Ejecutar**

```bash
# Crear archivo de configuración (opcional)
touch .env
echo "NODE_ENV=development" >> .env
echo "PORT=8601" >> .env

# Ejecutar en modo desarrollo
npm start

# La aplicación estará disponible en:
# http://localhost:8601
```

**⏱️ Tiempo estimado**: 1-2 minutos  
**🔧 Propósito**: Configuración y ejecución

---

## 🔍 Script de Verificación

Crea un archivo `verificar-instalacion.sh`:

```bash
#!/bin/bash

echo "🔍 Verificando instalación de OpenBlock GUI..."
echo "================================================"

# Verificar macOS
echo "📱 macOS:"
sw_vers | grep "ProductVersion"

# Verificar Xcode Command Line Tools
echo "🔧 Xcode Command Line Tools:"
if xcode-select -p &> /dev/null; then
    echo "✅ Instalado: $(xcode-select -p)"
else
    echo "❌ No instalado"
fi

# Verificar Homebrew
echo "🍺 Homebrew:"
if command -v brew &> /dev/null; then
    echo "✅ Instalado: $(brew --version | head -n1)"
else
    echo "❌ No instalado"
fi

# Verificar Node.js
echo "🟢 Node.js:"
if command -v node &> /dev/null; then
    echo "✅ Instalado: $(node --version)"
else
    echo "❌ No instalado"
fi

# Verificar npm
echo "📦 npm:"
if command -v npm &> /dev/null; then
    echo "✅ Instalado: $(npm --version)"
else
    echo "❌ No instalado"
fi

# Verificar Git
echo "📝 Git:"
if command -v git &> /dev/null; then
    echo "✅ Instalado: $(git --version)"
else
    echo "❌ No instalado"
fi

# Verificar Python
echo "🐍 Python:"
if command -v python3 &> /dev/null; then
    echo "✅ Instalado: $(python3 --version)"
else
    echo "❌ No instalado"
fi

# Verificar Arduino CLI
echo "🔌 Arduino CLI:"
if command -v arduino-cli &> /dev/null; then
    echo "✅ Instalado: $(arduino-cli version)"
else
    echo "❌ No instalado"
fi

# Verificar VS Code
echo "💻 VS Code:"
if command -v code &> /dev/null; then
    echo "✅ Instalado: $(code --version | head -n1)"
else
    echo "❌ No instalado"
fi

echo "================================================"
echo "✅ Verificación completada"
```

**Ejecutar verificación:**
```bash
chmod +x verificar-instalacion.sh
./verificar-instalacion.sh
```

---

## 🚨 Solución de Problemas

### **Error: "xcode-select: error: command line tools are already installed"**
```bash
# Reinstalar Command Line Tools
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

### **Error: "brew: command not found"**
```bash
# Agregar Homebrew al PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

### **Error: "npm: command not found"**
```bash
# Reinstalar Node.js
brew uninstall node
brew install node
```

### **Error: "Permission denied"**
```bash
# Arreglar permisos
sudo chown -R $(whoami) /usr/local/lib/node_modules
```

### **Error: "Out of memory"**
```bash
# Aumentar memoria de Node.js
export NODE_OPTIONS="--max-old-space-size=4096"
npm start
```

---

## 📊 Resumen de Instalación

### **Tiempo Total Estimado**: 30-45 minutos
### **Espacio en Disco**: ~1.5GB
### **Componentes Instalados**: 8

| Componente | Estado | Tamaño | Tiempo |
|------------|--------|--------|--------|
| Xcode Command Line Tools | ✅ | 500MB | 10 min |
| Homebrew | ✅ | 50MB | 3 min |
| Node.js | ✅ | 100MB | 3 min |
| Git | ✅ | 50MB | 2 min |
| Python 3 | ✅ | 100MB | 5 min |
| Arduino CLI | ✅ | 50MB | 8 min |
| VS Code | ✅ | 300MB | 3 min |
| OpenBlock GUI | ✅ | 200MB | 10 min |

---

## 🎯 Próximos Pasos

1. **Ejecutar OpenBlock GUI**: `npm start`
2. **Abrir navegador**: `http://localhost:8601`
3. **Seleccionar dispositivo**: Arduino, ESP32, etc.
4. **Comenzar a programar**: Bloques visuales + código real

---

## 📞 Soporte

- **Documentación**: https://wiki.openblock.cc
- **Comunidad**: https://gitter.im/openblockcc/community
- **Issues**: https://github.com/openblockcc/openblock-gui/issues
- **QQ群 (Chino)**: 933484739

---

**¡Listo! Ahora tienes todo lo necesario para usar OpenBlock GUI con todas sus funcionalidades de hardware.**
