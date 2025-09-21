# 🚀 Instalación Paso a Paso - OpenBlock GUI para macOS

## 📋 Lista de Tareas (TODO)

### **FASE 1: Verificación del Sistema**
- [ ] 1.1 Verificar versión de macOS
- [ ] 1.2 Verificar arquitectura del procesador
- [ ] 1.3 Verificar memoria RAM
- [ ] 1.4 Verificar espacio en disco

### **FASE 2: Herramientas de Desarrollo Base**
- [ ] 2.1 Verificar/Instalar Xcode Command Line Tools
- [ ] 2.2 Verificar/Instalar Homebrew
- [ ] 2.3 Configurar Homebrew en PATH

### **FASE 3: Runtime de JavaScript**
- [ ] 3.1 Verificar/Instalar Node.js
- [ ] 3.2 Verificar/Instalar npm
- [ ] 3.3 Verificar versiones compatibles

### **FASE 4: Control de Versiones**
- [ ] 4.1 Verificar/Instalar Git
- [ ] 4.2 Configurar Git (usuario y email)
- [ ] 4.3 Configurar editor por defecto

### **FASE 5: Herramientas de Hardware**
- [ ] 5.1 Verificar/Instalar Python 3
- [ ] 5.2 Instalar herramientas Python (esptool, pyserial)
- [ ] 5.3 Verificar/Instalar Arduino CLI
- [ ] 5.4 Configurar Arduino CLI
- [ ] 5.5 Instalar cores de Arduino (AVR, ESP32)

### **FASE 6: Editor de Código**
- [ ] 6.1 Verificar/Instalar Visual Studio Code
- [ ] 6.2 Instalar extensiones útiles
- [ ] 6.3 Verificar configuración

### **FASE 7: OpenBlock GUI**
- [ ] 7.1 Clonar repositorio de OpenBlock GUI
- [ ] 7.2 Instalar dependencias (npm install)
- [ ] 7.3 Crear archivo de configuración (.env)
- [ ] 7.4 Verificar instalación

### **FASE 8: Ejecución y Pruebas**
- [ ] 8.1 Ejecutar OpenBlock GUI (npm start)
- [ ] 8.2 Verificar que la aplicación carga correctamente
- [ ] 8.3 Probar funcionalidades básicas
- [ ] 8.4 Verificar conexión con hardware (opcional)

---

## 📝 **Comandos para Cada Paso**

### **FASE 1: Verificación del Sistema**

#### **1.1 Verificar versión de macOS**
```bash
sw_vers
```
**Resultado esperado**: `ProductVersion: 13.x.x` o superior

#### **1.2 Verificar arquitectura del procesador**
```bash
uname -m
```
**Resultado esperado**: `x86_64` (Intel) o `arm64` (Apple Silicon)

#### **1.3 Verificar memoria RAM**
```bash
sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024)}'
```
**Resultado esperado**: 8 o más GB

#### **1.4 Verificar espacio en disco**
```bash
df -h . | awk 'NR==2 {print $4}'
```
**Resultado esperado**: 5 o más GB libres

---

### **FASE 2: Herramientas de Desarrollo Base**

#### **2.1 Verificar Xcode Command Line Tools**
```bash
xcode-select -p
```
**Si NO está instalado**:
```bash
xcode-select --install
```
**Esperar a que aparezca la ventana de instalación y hacer clic en "Install"**

#### **2.2 Verificar Homebrew**
```bash
brew --version
```
**Si NO está instalado**:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### **2.3 Configurar Homebrew en PATH**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
brew --version
```

---

### **FASE 3: Runtime de JavaScript**

#### **3.1 Verificar Node.js**
```bash
node --version
```
**Si NO está instalado**:
```bash
brew install node
```

#### **3.2 Verificar npm**
```bash
npm --version
```

#### **3.3 Verificar versiones compatibles**
```bash
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
```
**Versiones esperadas**: Node.js 16.x+ y npm 8.x+

---

### **FASE 4: Control de Versiones**

#### **4.1 Verificar Git**
```bash
git --version
```
**Si NO está instalado**:
```bash
brew install git
```

#### **4.2 Configurar Git**
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

#### **4.3 Configurar editor por defecto**
```bash
git config --global core.editor "code --wait"
```

---

### **FASE 5: Herramientas de Hardware**

#### **5.1 Verificar Python 3**
```bash
python3 --version
```
**Si NO está instalado**:
```bash
brew install python@3.11
```

#### **5.2 Instalar herramientas Python**
```bash
pip3 install esptool pyserial
```

#### **5.3 Verificar Arduino CLI**
```bash
arduino-cli version
```
**Si NO está instalado**:
```bash
brew install arduino-cli
```

#### **5.4 Configurar Arduino CLI**
```bash
arduino-cli config init
```

#### **5.5 Instalar cores de Arduino**
```bash
arduino-cli core install arduino:avr
arduino-cli core install esp32:esp32
```

---

### **FASE 6: Editor de Código**

#### **6.1 Verificar Visual Studio Code**
```bash
code --version
```
**Si NO está instalado**:
```bash
brew install --cask visual-studio-code
```

#### **6.2 Instalar extensiones útiles**
```bash
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.arduino
```

#### **6.3 Verificar configuración**
```bash
code --version
```

---

### **FASE 7: OpenBlock GUI**

#### **7.1 Clonar repositorio**
```bash
git clone https://github.com/openblockcc/openblock-gui.git
cd openblock-gui
```

#### **7.2 Instalar dependencias**
```bash
npm install
```

#### **7.3 Crear archivo de configuración**
```bash
touch .env
echo "NODE_ENV=development" >> .env
echo "PORT=8601" >> .env
```

#### **7.4 Verificar instalación**
```bash
npm list --depth=0
```

---

### **FASE 8: Ejecución y Pruebas**

#### **8.1 Ejecutar OpenBlock GUI**
```bash
npm start
```

#### **8.2 Verificar que la aplicación carga**
**Abrir navegador en**: `http://localhost:8601`

#### **8.3 Probar funcionalidades básicas**
- [ ] Interfaz carga correctamente
- [ ] Pestañas funcionan (Code, Costumes, Sounds)
- [ ] Bloques se pueden arrastrar
- [ ] Editor de código funciona

#### **8.4 Verificar conexión con hardware (opcional)**
- [ ] Seleccionar dispositivo Arduino
- [ ] Verificar que aparece en la interfaz
- [ ] Probar compilación de código

---

## 🎯 **Estado Actual del Progreso**

**Fase Completada**: ⬜ Ninguna  
**Pasos Completados**: 0/32  
**Porcentaje**: 0%

---

## 📊 **Resumen de Requisitos**

| Componente | Versión Mínima | Versión Recomendada | Estado |
|------------|----------------|-------------------|--------|
| macOS | 10.15 | 13.0+ | ⬜ |
| Xcode Command Line Tools | 12.0+ | Última | ⬜ |
| Homebrew | 3.0+ | 4.0+ | ⬜ |
| Node.js | 16.x | 18.x LTS | ⬜ |
| Git | 2.30+ | 3.0+ | ⬜ |
| Python 3 | 3.8+ | 3.11+ | ⬜ |
| Arduino CLI | 0.20+ | 0.32+ | ⬜ |
| VS Code | 1.70+ | 1.80+ | ⬜ |

---

## 🚨 **Notas Importantes**

- **Tiempo estimado total**: 30-45 minutos
- **Espacio en disco requerido**: ~1.5GB
- **Conexión a internet**: Requerida para descargas
- **Permisos de administrador**: Pueden ser necesarios

---

## 🔧 **Comandos de Verificación Rápida**

```bash
# Verificar todo de una vez
./verificar-instalacion.sh

# Verificar solo herramientas básicas
echo "Node.js: $(node --version 2>/dev/null || echo 'No instalado')"
echo "npm: $(npm --version 2>/dev/null || echo 'No instalado')"
echo "Git: $(git --version 2>/dev/null || echo 'No instalado')"
echo "Python: $(python3 --version 2>/dev/null || echo 'No instalado')"
echo "Arduino CLI: $(arduino-cli version 2>/dev/null || echo 'No instalado')"
```

---

**¡Empecemos con la FASE 1! 🚀**
