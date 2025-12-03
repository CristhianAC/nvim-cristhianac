# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# URL del repositorio de tu configuración de Neovim
NVIM_CONFIG_REPO="https://github.com/CristhianAC/nvim-cristhianac.git"

echo -e "${BLUE}Iniciando instalación automática...${NC}"

# Función para detectar el sistema operativo
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

if [ "$OS" == "unknown" ]; then
    echo -e "${RED}Sistema operativo no soportado.${NC}"
    exit 1
fi

echo -e "${GREEN}Sistema detectado: $OS${NC}"

# ==========================================
# INSTALACIÓN EN MACOS
# ==========================================
if [ "$OS" == "macos" ]; then
    # Instalar Homebrew si no existe
    if ! command -v brew &> /dev/null; then
        echo -e "${BLUE}Instalando Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Agregar Homebrew al PATH para esta sesión
        if [ -f "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -f "/usr/local/bin/brew" ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo -e "${GREEN}Homebrew ya está instalado.${NC}"
    fi

    echo -e "${BLUE}Actualizando Homebrew...${NC}"
    brew update

    # Instalar Ghostty
    echo -e "${BLUE}Instalando Ghostty...${NC}"
    # Eliminamos 2>/dev/null para ver errores si falla
    if brew install --cask ghostty; then
         echo -e "${GREEN}Ghostty instalado correctamente.${NC}"
    else
         echo -e "${RED}Fallo al instalar Ghostty via brew cask.${NC}"
         echo "Es posible que necesites descargarlo manualmente de https://ghostty.org"
    fi

    # Instalar dependencias (Neovim, Zsh, Git, Ripgrep, etc)
    echo -e "${BLUE}Instalando Neovim, Zsh y herramientas...${NC}"
    if brew install neovim zsh git curl ripgrep fd lazygit; then
        echo -e "${GREEN}Herramientas instaladas correctamente.${NC}"
    else
        echo -e "${RED}Fallo al instalar herramientas.${NC}"
        exit 1
    fi

# ==========================================
# INSTALACIÓN EN LINUX
# ==========================================
elif [ "$OS" == "linux" ]; then
    # Detectar distribución (simplificado para Debian/Ubuntu y Arch)
    if [ -f /etc/debian_version ]; then
        echo -e "${BLUE}Detectado Debian/Ubuntu...${NC}"
        sudo apt update
        sudo apt install -y zsh git curl ripgrep fd-find
        
        # Instalar Neovim (versión reciente via snap o appimage recomendada, aquí usamos snap para facilitar)
        if command -v snap &> /dev/null; then
            sudo snap install nvim --classic
        else
            echo -e "${RED}Snap no encontrado. Instalando neovim de repositorios (puede ser antiguo).${NC}"
            sudo apt install -y neovim
        fi

        # Ghostty en Linux (puede variar)
        echo -e "${BLUE}Instalando Ghostty (instrucciones pueden variar)...${NC}"
        if command -v snap &> /dev/null; then
             sudo snap install ghostty --classic 2>/dev/null || echo -e "${RED}No se encontró paquete snap para Ghostty. Revisa https://ghostty.org${NC}"
        else
             echo -e "${RED}Por favor instala Ghostty manualmente desde https://ghostty.org${NC}"
        fi

    elif [ -f /etc/arch-release ]; then
        echo -e "${BLUE}Detectado Arch Linux...${NC}"
        sudo pacman -Syu --noconfirm zsh neovim git curl ripgrep fd lazygit ghostty
    fi
fi

# ==========================================
# CONFIGURACIÓN DE ZSH
# ==========================================
echo -e "${BLUE}Configurando Zsh...${NC}"

# Instalar Oh My Zsh (Opcional, pero recomendado para "instalación rápida y bonita")
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Cambiar shell por defecto a zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Cambiando shell por defecto a Zsh..."
    chsh -s "$(which zsh)"
fi

# ==========================================
# CONFIGURACIÓN DE NEOVIM
# ==========================================
echo -e "${BLUE}Configurando Neovim...${NC}"

NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Backup de configuración existente
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "Haciendo backup de la configuración existente..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.bak.$(date +%s)"
fi

# Clonar repositorio
echo "Clonando tu configuración de Neovim..."
git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Configuración de Neovim instalada correctamente.${NC}"
else
    echo -e "${RED}Fallo al clonar el repositorio.${NC}"
    exit 1
fi

echo -e "${GREEN}¡Instalación completada!${NC}"
echo "Reinicia tu terminal o abre Ghostty para ver los cambios."
EOF