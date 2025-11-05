Berta K Fashion - Template multi-marca (A Elegância Feminina)
------------------------------------------------------------

Conteúdo:
- Projeto Flutter mínimo pronto para build.
- Arquivo config.json para personalizar app_name, brand_name, contact e logo.
- Workflow GitHub Actions para compilar debug e release APKs automaticamente.

Passos para usar com GitHub Actions (opção B/C):
1) Crie um repositório no GitHub (público ou privado).
2) Faça upload de todos os ficheiros deste pacote para o repositório.
3) Ao enviar (push) para a branch 'main', o GitHub Actions irá iniciar o build automaticamente.
4) Verifique a aba "Actions" do repositório; quando o workflow terminar, os APKs estarão disponíveis como artefacts.

Nomes dos artefactos gerados pela workflow:
- A_Elegancia_Feminina-debug.apk
- A_Elegancia_Feminina-release.apk

Se preferir construir localmente (no PC com Flutter SDK):
1) Abra terminal na pasta do projeto.
2) flutter pub get
3) flutter build apk --debug
4) flutter build apk --release
5) APKs serão gerados em build/app/outputs/flutter-apk/

Notas:
- Release APK pode precisar de assinatura para publicação em loja. O workflow gera um release apk não-assinado (útil para testes) a menos que forneça keystore e variáveis.
- Se o repositório for privado, GitHub Actions ainda funciona; artefacts ficam disponíveis apenas para quem tem acesso ao repo.

Contato para suporte: bertakumbo53@gmail.com
