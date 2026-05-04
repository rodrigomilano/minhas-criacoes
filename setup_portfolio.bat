@echo off
echo [1/4] Inicializando Repositorio de Portfolio...
git init

echo [2/4] Adicionando projetos (ignorando evoke e Laje Digital)...
git add .

echo [3/4] Criando commit inicial...
git commit -m "feat: initial commit with selected portfolio projects"

echo [4/4] Criando repositorio no GitHub: minhas-criacoes
gh repo create minhas-criacoes --public --source=. --remote=origin --push

echo.
echo [+] Portfolio enviado com sucesso para o GitHub!
pause
