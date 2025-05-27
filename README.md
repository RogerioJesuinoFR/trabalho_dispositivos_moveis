<h1>📱 Aplicativo de Cadastro e Estatísticas Corporais</h1>
<b>Este projeto é um aplicativo mobile Flutter onde o usuário pode:</b>

- Realizar cadastro de conta (com validações completas)

- Realizar login

- Visualizar e atualizar estatísticas corporais (peso, altura, percentual de gordura, IMC calculado automaticamente)

- Projeto estruturado em padrão MVC

- Formulários com validação de dados, tratamento de erros e interface amigável

<h2>🚀Tecnologias Utilizadas</h2>

-Flutter (SDK recomendado: Flutter 3.19 ou superior)

- Dart

<i>Editor sugerido: Visual Studio Code com plugins de Flutter/Dart</i>

Dependências:

flutter/material (nativo)

🛠️ Requisitos para rodar o projeto
Antes de iniciar, você precisará ter instalado:

Flutter SDK (versão 3.19 ou superior)

Dart SDK (geralmente já incluído com Flutter)

Android Studio ou VS Code

Emulador Android ou dispositivo físico para testes

Git (opcional, para clonar repositório)

Verificar instalação:

```
flutter doctor
```
> Esse comando mostra se o Flutter, Dart e SDKs estão corretamente instalados.

<h2>📦 Como rodar o projeto</h2>

1. Clone o repositório ou copie os arquivos do projeto.
```
git clone https://github.com/RogerioJesuinoFR/trabalho_dispositivos_moveis.git
```

2. Acesse a pasta do projeto:
```
cd trabalho_dispositivos_moveis
```

3. (Opcional) Se necessário, atualize as dependências:
```
flutter pub get
```

4. Rode o projeto em um emulador ou dispoisitivo físico:
```
flutter run
```

<h2>📂 Estrutura de Pastas</h2>
```
lib/
 ├── models/
 │    ├── imc_record.dart
 │    └── user.dart
 ├── service/
 │    ├── api_service.dart
 │    ├── auth_service.dart
 │    ├── camera_service.dart
 │    ├── database_service.dart
 │    ├── image_service.dart
 │    ├── imc_service.dart
 │    └── register_page.dart
 ├── viewmodels/
 │    ├── home_viewmodel.dart
 │    └── login_viewmodel.dart
 ├── views/
 │    ├── health_tips_page.dart
 │    ├── history_page.dart
 │    ├── home_page.dart
 │    ├── imc_page.dart
 │    ├── login_page.dart
 │    ├── profile_page.dart
 │    ├── register_page.dart
 │    └── register_page.dart
 └── main.dart
```

<h2>📋 Funcionalidades Implementadas</h2>
- Cadastro de usuário com:
    - Nome completo (obrigatório ter pelo menos um sobrenome)
    - Senha segura (mínimo 8 caracteres, 1 maiúscula, 1 especial)
- Login de usuário
- Visualização e atualização dos dados corporais:
    - Altura (aceitando valores decimais, em metros)
    - Peso
    - IMC calculado automaticamente
- Formulários com mensagens de erro e validações

<h2>🔥 Observações Importantes</h2>

<h3>💬 Suporte</h3>
Em caso de dúvidas ou problemas, abra uma issue ou entre em contato com o responsável.

<h3>✨ Autor</h3>
Desenvolvido como parte do trabalho acadêmico para a disciplina de Desenvolvimento Mobile.