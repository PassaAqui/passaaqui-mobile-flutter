# Guia de Contribuição

Este documento orienta como trabalhar neste projeto Flutter. Leia com atenção antes de começar.

---

## Estrutura do projeto

```
lib/
├── app/          -> ponto de entrada, tema e rotas (GoRouter)
├── core/         -> código compartilhado entre todas as features (network, theme, widgets genéricos)
└── features/     -> uma pasta por funcionalidade (home, auth, map, shop)
```

---

## Regras da arquitetura

### app/

A pasta `app/` é **apenas** o ponto de entrada do aplicativo. Ela contém:
- Configuração do `MaterialApp` / `MaterialApp.router`
- Definição do tema global
- Configuração das rotas com GoRouter

**Não coloque lógica de tela aqui.** Telas ficam em `features/`.

### features/

Cada funcionalidade tem sua própria pasta dentro de `features/`. Exemplo:

```
features/
├── auth/
│   ├── screens/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   └── widgets/
│       └── .gitkeep
```

#### screens/

Contém **apenas** os arquivos de tela (páginas completas).

- Um arquivo por tela
- Nome do arquivo: `snake_case` terminado em `_screen.dart` (ex: `login_screen.dart`, `global_shop_screen.dart`)
- Nome da classe: `PascalCase` igual ao arquivo (ex: `LoginScreen`, `GlobalShopScreen`)
- Imports: sempre comece com `import 'package:flutter/material.dart';`
- A tela **não contém** chamadas de API, clientes HTTP, lógica de negócio, validações complexas ou regras de domínio
- A tela **apenas consome dados prontos** expostos via Provider (gerenciamento de estado)
- Se um dado necessário ainda não existe no Provider, a tela fica com dado mockado ou placeholder até o Provider ser implementado — não se cria chamada direta de API na tela

**Exemplo de tela StatelessWidget (página estática):**

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Login Screen'),
      ),
    );
  }
}
```

**Exemplo de tela StatefulWidget (página com estado local — ex: formulário, animação, toggle):**

```dart
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Informe o email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Informe a senha' : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // TODO: chamar ação do Provider (ex: context.read<AuthProvider>().signup(...))
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

#### widgets/

Componentes visuais reutilizáveis **dentro da mesma feature**. Exemplos: botões customizados, cards, campos de formulário, modais.

- Um arquivo por widget
- Nome do arquivo: `snake_case` descritivo (ex: `product_card.dart`, `custom_button.dart`, `email_field.dart`)
- Nome da classe: `PascalCase` igual ao arquivo (ex: `ProductCard`, `CustomButton`, `EmailField`)
- Widgets que são detalhe de implementação de uma tela ficam no **mesmo arquivo** da tela, com prefixo `_` (ex: `_LoginForm`)
- Widgets que podem ser reutilizados em outras telas da mesma feature vão para `widgets/`
- **Não criam** pastas `services/`, `models/`, `providers/`, `repositories/` ou `validators/` dentro da feature — essas pastas não existem e não devem ser criadas; a lógica de API, modelos de dados e estado global ficam fora de `features/` e são responsabilidade da arquitetura central

---

⚠️ **REGRA IMPORTANTE: Telas e widgets NUNCA chamam API diretamente**

- Não use `http`, `dio` ou qualquer cliente HTTP dentro de `screens/` ou `widgets/`
- Não coloque lógica de negócio (cálculos, validações complexas, regras de negócio) nas telas
- As telas **apenas consomem dados prontos** que virão via **Provider** (gerenciamento de estado)
- Mesmo que o Provider ainda não exista, **não faça gambiarra** chamando API na tela
- Se algo "falta" (um service, um provider, um model), é porque ainda não foi implementado — **não crie por conta própria**

---

### core/

Código compartilhado entre features:
- `core/network/` → cliente HTTP (`api_client.dart`) — configuração central de Dio/HTTP, interceptors, base URL
- `core/theme/` → tema global (`app_theme.dart`) — `ThemeData` completo: cores, tipografia, `InputDecorationTheme`, `ElevatedButtonThemeData`, etc.
- `core/widgets/` → widgets genéricos reutilizáveis em todo o app (ex: `loading_indicator.dart`, `empty_state.dart`, `error_display.dart`)

**Cores e estilos:** nunca hardcode cores na tela (ex: `Colors.blue`, `Color(0xFF123456)`). Use `Theme.of(context)` para acessar `colorScheme`, `textTheme`, etc. Novas cores/estilos globais são adicionados apenas em `core/theme/app_theme.dart`.

**Novas dependências (pacotes no `pubspec.yaml`)** não devem ser adicionadas sem alinhamento prévio, pois podem conflitar com a arquitetura do projeto.

---

## Convenções de nomenclatura

| Item | Convenção | Exemplos do projeto |
|------|-----------|---------------------|
| Arquivos | `snake_case.dart` | `login_screen.dart`, `product_card.dart` |
| Classes (widgets/screens) | `PascalCase` | `LoginScreen`, `ProductCard` |
| Sufixo de tela | `_screen.dart` | `login_screen.dart`, `global_shop_screen.dart` |
| Widgets reutilizáveis | nome descritivo simples | `product_card.dart`, `custom_button.dart` |
| Widgets privados (mesmo arquivo) | `_` prefixo + `PascalCase` | `_LoginForm`, `_ProductListItem` |
| Variáveis/métodos privados | `_` prefixo + `camelCase` | `_emailController`, `_validateForm()` |
| Constantes | `lowerCamelCase` ou `SCREAMING_SNAKE_CASE` | `defaultPadding`, `MAX_RETRIES` |

**Regras obrigatórias:**
- Um widget público por arquivo
- Nome do arquivo = nome da classe em `snake_case`
- Imports organizados: 1) `package:flutter/material.dart` (sempre primeiro), 2) pacotes externos, 3) imports relativos do projeto (`../../core/...`, `../widgets/...`)

```dart
// login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget { ... }

// product_card.dart
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget { ... }

// _login_form.dart (se extraído para arquivo próprio, o que é raro)
import 'package:flutter/material.dart';

class _LoginForm extends StatelessWidget { ... }
```

---

## Organização do código

### Evite widgets gigantes

Se o método `build()` passar de **100–150 linhas**, quebre em widgets menores:

- No **mesmo arquivo** (widgets privados com `_` no início)
- Ou em `widgets/` da feature se for reutilizável em mais de uma tela

```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginForm(),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ... conteúdo do formulário
  }
}
```

### Evite duplicação

Antes de criar um widget novo:
1. Verifique `core/widgets/` (compartilhados entre features)
2. Verifique `features/sua-feature/widgets/` (da própria feature)
3. Só crie se não existir nada parecido

### Padrão de imports

```dart
// 1. Flutter SDK (sempre primeiro)
import 'package:flutter/material.dart';

// 2. Pacotes externos (go_router, provider, etc.)
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// 3. Imports relativos do projeto (core/)
import '../../core/theme/app_theme.dart';
import '../../core/widgets/loading_indicator.dart';

// 4. Imports relativos da feature (widgets/, screens/)
import '../widgets/custom_button.dart';
import '../widgets/email_field.dart';
```

---

## Commits e Git Flow

### Branches do projeto

| Branch | Propósito | Quem pode commitar direto? |
|--------|-----------|----------------------------|
| `main` | Produção | **Ninguém** |
| `develop` | Integração principal | **Ninguém** (só via PR) |
| `feature/*` | Uma por tarefa/tela | Você (na sua branch) |

---

### Fluxo de trabalho

#### 1. Antes de começar qualquer tarefa

```bash
git checkout develop
git pull origin develop
```

#### 2. Crie sua branch a partir da `develop`

Padrão: `feature/nome-da-feature` (kebab-case)

```bash
git checkout -b feature/login-screen
git checkout -b feature/shop-product-card
git checkout -b feature/map-poi-modal
```

#### 3. Faça commits pequenos e descritivos

Use **Conventional Commits**:

| Tipo | Quando usar | Exemplo |
|------|-------------|---------|
| `feat` | Nova funcionalidade | `feat(auth): add login screen layout` |
| `fix` | Correção de bug | `fix(shop): correct product card alignment` |
| `refactor` | Refatoração sem mudar comportamento | `refactor(auth): extract email field widget` |
| `style` | Formatação, espaçamento, semântica | `style(core): format loading_indicator.dart` |
| `docs` | Documentação | `docs: update contributing guide` |

#### 4. Envie sua branch

```bash
git push origin feature/nome-da-feature
```

#### 5. Abra Pull Request

- **Sempre** da sua branch `feature/*` para `develop`
- **NUNCA** para `main`
- Abra o PR **pela interface do GitHub** (não use merge direto no terminal)

---

### Checklist antes de abrir o PR

- [ ] `flutter run` compila e roda sem erros
- [ ] `flutter analyze` não retorna erros
- [ ] Estrutura de pastas segue este documento
- [ ] Nomenclatura segue este documento
- [ ] Imports organizados conforme padrão (Flutter → externos → core/ → feature/)
- [ ] Nenhuma chamada de API, `http`, `dio` ou lógica de negócio em `screens/` ou `widgets/`
- [ ] Nenhuma cor hardcodada — usa `Theme.of(context)`
- [ ] Nenhuma pasta `services/`, `models/`, `providers/` criada dentro de `features/`