# Anime Characters Flutter

Aplicación Flutter para explorar personajes de **Naruto**, **One Piece** y **Dragon Ball Z**.  
Filtra por serie, busca por nombre y consulta la ficha detallada de cada personaje con animaciones y carga optimizada de imágenes.

---

## 📋 Characters View (Pantalla Principal)

En esta vista:

1. Al arrancar, carga los personajes de la serie seleccionada (o de todas si está en “All”).
2. `GridView` de 3 columnas con sus imágenes y nombres.
3. Spinner de carga mientras espera la respuesta de la API.
4. Al pulsar una tarjeta, solicita el detalle y navega a la vista de detalles.

### 1 · Pantalla Principal – Grid de personajes

<p align="center">
  <img width="231" alt="image" src="https://github.com/user-attachments/assets/f0c04bfa-1620-4d83-b2f2-6ce736860a11" />
</p>

---

### 2 · Filtro por Serie

El dropdown con opciones **All**, **Naruto**, **One Piece** y **Dragon Ball Z** recarga automáticamente el grid al cambiar.

<p align="center">
  <img width="230" alt="image" src="https://github.com/user-attachments/assets/8fc9eb2f-e04a-47ec-8a3c-e95c032bb35b" />
</p>

---

### 3 · Búsqueda por Nombre

La barra superior filtra en tiempo real los personajes cuyo nombre contiene el texto introducido.

<p align="center">
  <img width="227" alt="image" src="https://github.com/user-attachments/assets/749dbe0a-0599-4b4d-9391-e6eb8f539110" />
</p>

---

## 📖 Character Details View

En esta pantalla:

1. **Hero Animation** al ampliar la imagen desde la tarjeta.
2. Muestra el nombre completo y opcionalmente el kanji.
3. Botón “Details” oscuro que despliega un bloque con **AnimatedCrossFade**.
4. El bloque contiene las líneas de metadatos (edad, altura, afiliación…) sobre fondo gris oscuro.

### 4 · Vista de Detalles

<p align="center">
  <img width="224" alt="image" src="https://github.com/user-attachments/assets/7cb21cde-4325-49a7-96b3-40f69d51b95c" />
</p>

---

## ⚙️ Instalación

1. Clona el repositorio:
   ```bash
   git clone https://tu-repositorio.git
   cd anime-characters-flutter
   flutter pub get
   flutter run
