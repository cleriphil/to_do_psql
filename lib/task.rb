class Task
  attr_reader(:description)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec('SELECT * FROM task;')
    all_tasks = []
    returned_tasks.each() do |task|
      description = task.fetch('description')
      all_tasks.push(Task.new({:description => description}))
    end
    all_tasks
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description())
  end

  define_method(:save) do
    DB.exec("INSERT INTO task (description) VALUES ('#{@description}')")
  end
end
