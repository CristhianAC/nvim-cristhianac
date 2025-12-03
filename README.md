Mi configuración personal de Neovim basada en LazyVim.

## Instalación Automática

Puedes instalar esta configuración y todas sus dependencias (incluyendo Neovim, Zsh, Oh My Zsh, Ghostty, etc.) con un solo comando. No es necesario clonar el repositorio manualmente.

### macOS y Linux

Abre tu terminal y ejecuta:

```bash
bash <(curl -s https://raw.githubusercontent.com/CristhianAC/nvim-cristhianac/main/install_setup.sh)
```

Este script se encargará de:

1.  Detectar tu sistema operativo.
2.  Instalar dependencias necesarias (Homebrew, git, ripgrep, etc.).
3.  Instalar y configurar Zsh y Oh My Zsh.
4.  Instalar Ghostty (Terminal).
5.  Hacer un backup de tu configuración actual de Neovim.
6.  Clonar e instalar esta configuración.

## Requisitos Previos

- Conexión a internet.
- `curl` instalado (usualmente viene por defecto).

## Post-Instalación

Una vez finalizado el script:

1.  Reinicia tu terminal o abre Ghostty.
2.  Ejecuta `nvim`. LazyVim instalará los plugins automáticamente en el primer inicio.
    EOF
