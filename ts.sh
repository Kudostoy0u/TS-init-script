echo '
function tsinit {
    fail() { : "${TSinit:?$1}"; }
    if [[ $# -eq 0 ]] ; then
        fail "Please supply an argument"
    fi
    mkdir $1
    cd $1
    npm init -y
    git init
    npm i -D typescript @types/node prettier eslint eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
    touch .prettierrc
    touch .eslintrc.json
    touch tsconfig.json
    touch .gitignore
    echo "$(sed '\''6 a   "prestart": "tsc --build",'\'' package.json)" > package.json
    echo "$(sed '\''7 a   "start": "node dist/index.js",'\'' package.json)" > package.json
    echo "$(sed '\''8 a   "build": "tsc --build",'\'' package.json)" > package.json
    echo '\''{
    "tabWidth": 4,
    "printWidth": 80,
    "trailingComma": "all",
    "semi": true
}'\'' > .prettierrc
    echo '\''{
    "extends": [
        "prettier",
        "plugin:@typescript-eslint/recommended",
        "prettier/@typescript-eslint"
    ],
    "parser": "@typescript-eslint/parser"
}'\'' > .eslintrc.json
    echo '\''{
    "compilerOptions": {
        "target": "ES2020",
        "module": "CommonJS",
        "moduleResolution": "node",
        "skipLibCheck": true,
        "resolveJsonModule": true,
        "esModuleInterop": true,
        "emitDecoratorMetadata": true,
        "experimentalDecorators": true,
        "allowSyntheticDefaultImports": true,
        "declaration": false,
        "outDir": "dist"
    },
    "include": ["src"],
    "exclude": ["node_modules", "**/*.spec.ts"]
}'\'' > tsconfig.json
    echo '\''# Distribution
dist
out
build
node_modules

# Logs
*.log*
logs

# Environment
*.env*

# Misc
.DS_Store'\'' > .gitignore
    mkdir src
    cd src
    touch index.ts
    echo "Initialized TS project!"
    cd ..
}
tsinstall() {
eval "npm i $1 && npm i @types/$1"
}' >> ~/.bashrc