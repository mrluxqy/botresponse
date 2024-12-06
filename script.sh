#!/bin/bash

# Función para mostrar texto en colores
function print_color() {
    local color_code=$1
    shift
    echo -e "\e[${color_code}m$@\e[0m"
}

# Mostrar bienvenida en ASCII
function bienvenida_ascii() {
    clear
    print_color 32 "====================================="
    print_color 36 "       BIENVENIDO A RESPONSE BOT     "
    print_color 32 "====================================="
    print_color 34 "     Preparando el entorno...        "
    print_color 34 "      By @Lux_qy                     "
    print_color 32 "====================================="
}

# Función para instalar dependencias
function instalar_dependencias() {
    # Preguntar al usuario el tipo de plataforma
    print_color 33 "Selecciona una opción para instalación:"
    print_color 33 "1) Termux"
    print_color 33 "2) Linux"
    print_color 33 "3) CMD (Windows)"
    read -p "Ingresa tu opción (1, 2 o 3): " opcion

    case $opcion in
        1)
            print_color 33 "Instalación para Termux seleccionada."
            pkg update && pkg upgrade -y
            pkg install python jq -y
            ;;
        2)
            print_color 33 "Instalación para Linux seleccionada."
            sudo apt update && sudo apt upgrade -y
            sudo apt install python3 python3-pip jq -y
            ;;
        3)
            print_color 33 "Instalación para CMD seleccionada."
            print_color 34 "En Windows (CMD), asegúrate de haber instalado Python manualmente."
            print_color 36 "Verificando y actualizando pip..."
            python.exe -m pip install --upgrade pip
            print_color 36 "Instalando paquetes de Python: jq y pyrogram..."
            pip install jq pyrogram
            print_color 32 "Paquetes instalados correctamente."
            ;;
        *)
            print_color 31 "Opción inválida. Saliendo..."
            exit 1
            ;;
    esac

    print_color 32 "Dependencias instaladas correctamente."
}

# Crear o modificar config.json para response.py
function configurar_config_json() {
    # Verificar si config.json existe o crearlo
    if [ ! -f "config.json" ]; then
        touch config.json
        echo "{}" > config.json
    fi

    # Pedir al usuario los valores de configuración
    api_id=$(read -p "Ingresa tu API ID: " && echo $REPLY)
    api_hash=$(read -p "Ingresa tu API Hash: " && echo $REPLY)
    respuesta_automatica=$(read -p "Ingresa el mensaje de respuesta automática: " && echo $REPLY)

    # Escribir la configuración en config.json
    jq --arg api_id "$api_id" \
       --arg api_hash "$api_hash" \
       --arg respuesta_automatica "$respuesta_automatica" \
       '.api_id = $api_id | .api_hash = $api_hash | .respuesta_automatica = $respuesta_automatica' config.json > config_temp.json

    mv config_temp.json config.json
    print_color 32 "El archivo config.json ha sido configurado correctamente."
}

# Mostrar bienvenida
bienvenida_ascii

# Instalar dependencias necesarias
instalar_dependencias

# Configurar el archivo config.json
configurar_config_json

# Finalización
print_color 32 "Instalación y configuración completadas exitosamente."
