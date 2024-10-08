# Way Airlines

Way Airlines é um aplicativo que exibe o histórico de voos e seus respectivos status. Ele foi desenvolvido sem o uso de dependências externas, adotando uma abordagem direta. O aplicativo permite ao usuário filtrar os voos com base em seu status e completion status, e visualizá-los em uma lista.

## Decisões de Desenvolvimento

- **Sem dependências externas**: Todo o código foi desenvolvido sem bibliotecas externas.
  
- **Filtragem no front-end**: O JSON fornecido continha todos os itens necessários. Em um cenário ideal, a filtragem dos dados seria feita no backend, mas como havia apenas uma massa de teste foi criado um filtro no front-end. Esse filtro foi feito com base nos campos `status` e `completionStatus`, permitindo que os dados filtrados fossem passados para a próxima tela de listagem.

- **Separação de telas**: As telas de listagem foram separadas da tela de histórico de voos. A tela de histórico contém as opções de filtragem e, ao selecionar um filtro, os dados filtrados são passados para a próxima tela, onde são exibidos.

- **Coordinators para navegação**: Foi utilizada a arquitetura de **Coordinators** para organizar a lógica de navegação, separando as responsabilidades e tornando o código mais modular.

- **Mock de dados e API real**: Para testar o comportamento da aplicação, o JSON foi hospedado em um link, permitindo a requisição de dados reais. No entanto, também foi implementado um mock dos dados. No arquivo `APIRequest`, pode-se escolher entre usar os dados mockados ou a requisição, bastando ajustar o booleano `useMockData`.

## Funcionalidades

- Filtragem de voos com base nos status e completion status.
- Navegação entre telas usando o padrão Coordinator.
- Suporte a mock de dados e requisição de dados reais via URL.
- Testes

## Instalação

Por não haver dependencias basta clonar o repositório e abri-lo com o Xcode

## Coordinators e Navegação

A navegação entre as telas foi implementada usando o padrão Coordinator. Esse padrão permite uma melhor organização da lógica de navegação e facilita a manutenção e escalabilidade da aplicação.

## Testes

Este projeto inclui testes unitários para garantir a correta funcionalidade das operações de filtragem e navegação. Os testes podem ser executados diretamente no Xcode.
Os testes cobrem cenários de sucesso e falha para a filtragem de voos e a exibição correta de erros.
