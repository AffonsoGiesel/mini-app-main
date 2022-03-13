#Nossas task customizadas


#Task de gerar o banco de dados automaticamente.
#Colocando um símbolo spinner de carregamento junto com a task.

namespace :dev do
  desc "Configura o ambiente de desenvolvimento."
  task setup: :environment do
    if !Rails.env.production?

      show_spinner("Apagando Banco de Dados...")do
        %x(rails db:drop)
      end

      show_spinner("Criando Banco de Dados...")do
        %x(rails db:create)
      end

      show_spinner("Migrando Banco de Dados...")do
        %x(rails db:migrate)
      end

      show_spinner("Populando Banco de Dados...")do
        %x(rails db:seed)
      end

    else
      puts "Você não está em ambiente de desenvolvimento."
    end

  end

end

private

def show_spinner(msg_inicial)
  spinner = TTY::Spinner.new("[:spinner] #{msg_inicial}")
  spinner.auto_spin
  #%x(rails db:seed)
  #Onde ficaria a task vamos chamar o 'Yield' para executar a task que existe do lado de fora do método.
  # Mais informações nas anotações na sessão do 'Yield'.
  yield
  spinner.success("(Concluído!)")
end
