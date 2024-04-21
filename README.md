# Implementación del Algoritmo de Unificación en LISP

Este proyecto consiste en la implementación del algoritmo de unificación en el lenguaje de programación LISP. 

## Instrucciones de Uso

Para ejecutar correctamente el archivo `prueba_ejecucion.lsp`, es necesario introducir la ruta correcta del archivo `unificacion.lsp` en una de las primeras líneas del archivo. Esto asegurará que las funciones necesarias estén disponibles para las pruebas.

### Sintaxis para Pruebas Manuales

Puedes realizar pruebas manuales utilizando la siguiente sintaxis:

- **Variables**: `(? x)`
- **Constantes**: `A`
- **Sustitución**: `((A /(? x))(B / (? y)))`
- **Literal**: `(P (? x) (? y))`

## Contenido del Repositorio

- **unificacion.lsp**: Contiene las funciones principales para el algoritmo de unificación.
- **prueba_ejecucion.lsp**: Contiene varias pruebas para validar el funcionamiento de las distintas funciones del algoritmo de unificación.
