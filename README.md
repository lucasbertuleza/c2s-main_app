# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# para ver o log completo do build

docker-compose build --progress plain

# AMBIENTE DE DESENVOLVIMENTO REMOTO

https://code.visualstudio.com/docs/devcontainers/attach-container#_attached-container-configuration-files

1. Copie o objeto JSON abaixo
2. F1 > Dev Containers: Open Attached Container Configuration File...
3. Selecione o nome da imagem/container na lista
4. Cole o conteúdo dentro do arquivo e salve

Pronto. Ao anexar no contâniner em execução, o preset será carregado.

# ATIVAR WEB-CONSOLE NO DOCKER (PARA RAILS 5+)

**config/development.rb**

```ruby
require 'socket'
require 'ipaddr'

config.web_console.whitelisted_ips = Socket.ip_address_list.reduce([]) do |res, addrinfo|
  addrinfo.ipv4? ? res << IPAddr.new(addrinfo.ip_address).mask(24) : res
end
```
# REFERÊNCIAS

- https://github.com/csstools/postcss-plugins/tree/main/plugins/postcss-custom-media
- https://bibwild.wordpress.com/2022/11/29/vite-ruby-for-js-css-asset-management-in-rails/
- https://maximomussini.com/posts/a-rubyist-guide-to-vite-js
- https://davidteren.medium.com/ruby-on-rails-7-high-performance-frontend-with-esbuild-rollup-vite-7712dea1917e
- https://dev.to/davidteren/ruby-on-rails-7-high-performance-frontend-development-with-esbuild-rollup-vite-2onj
- https://dev.to/pappijx/effortlessly-setting-up-your-react-project-with-vite-husky-typescript-and-eslint-a-comprehensive-guide-n5l
- https://luby.com.br/desenvolvimento/software/como-criar-um-projeto-com-vite/
- https://dev.to/buhrmi/setting-up-a-new-rails-7-app-with-vite-inertia-and-svelte-c9e

**TypeScript**

- https://duncanleung.com/eslint-mixed-javascript-typescript-files-codebase/
- https://www.robinwieruch.de/vite-typescript/
- https://ryanbigg.com/2023/06/rails-7-react-typescript-setup
- https://www.honeybadger.io/blog/typescript-rails/

**Plugins**

- https://js-from-routes.netlify.app/

**Templates**

- https://github.com/mattbrictson/rails-template
- https://github.com/zakariaf/rails-base-app
- https://github.com/BrandonShar/inertia-rails-template
- https://github.com/PhilVargas/vite-on-rails/tree/main
- https://github.com/templatus/templatus-vue
- https://github.com/ElMassimo/inertia-rails-ssr-template
- https://vuejsfeed.com/blog/templatus-vue-vue-3-and-ruby-on-rails-starter-template
- https://sasikala-r.medium.com/rails-7-with-vite-stimulus-tailwind-c3ecf2191ea9
- https://egghead.io/blog/rails-graphql-typescript-react-apollo

**Para ler**

- https://www.freecodecamp.org/news/what-is-postcss/
- https://github.com/airbnb/ruby
- https://evilmartians.com/chronicles/vite-lizing-rails-get-live-reload-and-hot-replacement-with-vite-ruby
- https://codeando.dev/posts/rails-inertiajs/

**Outros**

- https://dev.to/anukr98/setting-up-eslint-with-tsjs-in-your-react-project-in-2023-57o
- https://dev-yakuza.posstree.com/en/react-native/eslint-prettier-husky-lint-staged/#use-eslint-and-prettier-like-pro
- https://github.com/pappijx/Vite-react-eslint-prettier-husky-setup
- https://medium.com/@noe.abarai20/efficient-react-project-setup-with-vite-eslint-prettier-and-husky-22b683a01b53
- https://leandroaps.medium.com/setting-up-eslint-prettier-and-husky-in-a-typescript-based-react-18-project-a-comprehensive-8a87b91d5a28
- https://www.thisdot.co/blog/linting-formatting-and-type-checking-commits-in-an-nx-monorepo-with-husky/

**TODO**

- https://thoughtbot.com/blog/a-standard-way-to-lint-your-views

# POST INSTALL
- bundle exec rails g rspec:install
- bundle exec rails g bullet:install
- bundle exec rails g draper:install
- bundle exec vite install
- bundle exec rails_best_practices -g

**Reek**
https://www.youtube.com/watch?v=pazYe7WRWRU
https://github.com/troessner/reek/blob/master/docs/Reek-Driven-Development.md

**Brakeman**
https://github.com/presidentbeef/brakeman/blob/main/OPTIONS.md#configuration-files

# Ativando Extensão Ruby LSP no VSCode
1. Inicie o contêiner de desenvolvimento: Ctrl+Shift+P > Reabrir no contêiner
2. No terminal do Host execute o comando `docker-compose exec --user=root app ash -c "apk add --update --no-cache build-base"`
3. No VSCode, recarregue a janela: Ctrl+Shift+P > Recarregar janela

# REFS
- https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html
