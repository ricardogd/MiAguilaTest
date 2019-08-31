# MiAguilaTest
iOS Test Mi Águila

Este repositorio contiene una aplicación que da solución a un reto ténico elaborado por Mi Águila en el cuál se requiere:
1- Mostrar la posicón en tiempo real de un móvil siguiendo una ruta, añadiendo marcadores con cada ubicación sin eliminar las ubicaciones previas y haciendo uso de GPS y SDKs de mapas
2- Mostrar la velocidad del usuario en un view sobre el mapa implementado

##Solución entregada

Para dar solución al reto anteriormente planteado, se realizó una app que se puede dividir de la siguiente forma:
1- LaunchScreen: Pantalla en la cuál se muestra una leve animación presentando la aplicación
2- HomeScreen: Pantalla de inicio de la aplicación donde se lista la opción de mapa a visializar y cuenta un una sección de settings
3- SettingsScreen: Pantalla en la cuál se detallan los puntos de inicio y fin para los cuales se debe seguir la ruta en el mapa, además de un pibote de distancia el cuál indica la frecuencia del reporte de la ubicación de los datos. Estos parámetros pueden ser modificados en ésta pantalla y serán almacenados en la aplicación.
4- MapViewScreen: Pantalla que muestra el mapa y con él los puntos de inicio y fin así como la ruta trazada entre los puntos y el view que indica la velocidad del usuario. En ésta pantalla se entrega una gran cantidad de información adicional que se puede apreciar al seleccionar cada uno de los marcadores sobre la ruta.
5- Módulo de cache: Con el fin de mantener los datos de los ajustes almacenados en la app se realizó un pequeño módulo de cahce con el uso de NSUserDefault de iOS. 
6- Directions API: Con el fin de trazar una ruta para indicar el recorrido que se debe seguir entre los puntos de inicio y fin se hizo uso del API de Google de Directions él cuál nos permite con un llamado simple a un servicio conocer las rutas disponibles entre ambos puntos. Solo se muestra una ruta en el mapa. 
7- Frameworks de terceros: Para realizar la aplicación se incluyeron algunos frameworks de terceros haciendo uso de Cocoa-Pods como dependency manager. Estos frameworks fueron:
- Goole Maps SDK iOS
- Google Places iOS
- Lottie 

Esta solución fue desarrollada exclusivamente para iphone y no se añadió soporte para iPad. 

##Funcionamiento

Para que la aplicación pueda compilar y ser ejecutada se deben seguir los siguientes pasos:
1- Descargar el repositorio
2- Ejecutar pod install 
