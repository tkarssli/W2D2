class Employee
    attr_reader :name, :title, :salary, :boss 
    def initialize(name, title, salary, boss)
        @name = name
        @title = title 
        @salary = salary 
        @boss = boss 
    end

    def bonus(multiplier)
        salary * multiplier 
    end
end

class Manager < Employee 
    attr_reader :employees
    def initialize(name, title, salary, boss, employees)
        super(name, title, salary, boss)
        @employees = employees  
    end

    def bonus(multiplier)
        salary_sum * multiplier
    end

    def salary_sum
        return 0 if employees.empty?
        sum = 0
        employees.each do |emp|
            case emp 
            when Manager 
                sum += emp.salary
                sum += emp.salary_sum
            else 
                sum += emp.salary
            end
        end
        sum
    end
end

if __FILE__ == $PROGRAM_NAME
    david = Employee.new("David", "TA", 10_000, "Darren")
    shawna = Employee.new("Shawna", "TA", 12_000, "Darren")
    darren = Manager.new("Darren", "TA Manager", 78_000, "Ned", [david,shawna])
    ned = Manager.new("Ned", "Founder", 1_000_000, nil, [darren])
    p ned.bonus(5) # => 500_000
    p darren.bonus(4) # => 88_000
    p david.bonus(3) # => 30_000
end