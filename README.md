# 📖 Dictionary App

Aplicativo mobile desenvolvido em **Flutter** como parte de um **teste técnico da empresa [Coodash](https://www.coodash.com/)**.

Este app permite buscar palavras em inglês e exibe seus significados, pronúncia com áudio, classe gramatical e outras informações linguísticas úteis. Também é possível favoritar palavras para acesso posterior, bem como visualizar o histórico de buscas recentes.
O app encontra-se na pasta dictionary
---

## 🚀 Funcionalidades

- 🔍 **Busca de Palavras**: digite uma palavra em inglês e veja seus significados.
- 🔊 **Áudio de Pronúncia**: ouça a pronúncia da palavra (quando disponível).
- ⭐ **Favoritar Palavras**: adicione palavras aos favoritos para acesso rápido.
- 🕓 **Histórico de Palavras**: veja as palavras buscadas recentemente.
- 📱 **Compatível com Android e iOS**

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** – Framework principal para desenvolvimento mobile
- **Dart** – Linguagem utilizada com Flutter
- **Dio** – Cliente HTTP para comunicação com a API
- **Sqflite** – Banco de dados local com SQLite
- **Path Provider** – Acesso a diretórios do dispositivo
- **GetIt** – Injeção de dependência
- **ValueNotifier** – Gerenciamento de estado leve
- **Lottie** – Animações modernas baseadas em JSON
- **Font Awesome** – Ícones personalizados

---

## 📦 Dependências Principais

```yaml
environment:
  sdk: ">=3.1.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  dio: ^5.3.2
  sqflite: ^2.2.8+4
  path_provider: ^2.1.2
  get_it: ^7.6.7
  lottie: ^3.1.0
  font_awesome_flutter: ^10.7.0
```

---
---

## ▶️ Como Rodar o Projeto

### ✅ Pré-requisitos

- Flutter instalado ([guia oficial](https://docs.flutter.dev/get-started/install))
- Dispositivo físico ou emulador Android/iOS configurado

### 🔧 Passos

1. **Clone o repositório:**

```bash
git clone https://github.com/luiz-hms/mobile-challenge-coodash-mimo.git
cd mobile-challenge-coodash-mimo/dictionary
```

2. **Instale as dependências:**

```bash
flutter pub get
```

3. **Execute o app:**

```bash
flutter run
```

> 💡 Use `flutter doctor` para verificar se seu ambiente está corretamente configurado.

---

## 📄 Licença

Este projeto foi desenvolvido exclusivamente para fins de **avaliação técnica** pela empresa [Coodash](https://www.coodash.com/).  
Uso restrito à finalidade de avaliação.

---

## ✍️ Autor

Desenvolvido por **Luiz Henrique**  
🔗 [LinkedIn](https://www.linkedin.com/in/luiz-henrique-m-s/)  
💻 [GitHub](https://github.com/luiz-hms)

---
