CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      WITH RankedSalaries AS (
          SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) as rn
          FROM Employee
      )
      SELECT DISTINCT salary 
      FROM RankedSalaries
      WHERE rn = N
  );
END