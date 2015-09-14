require "./lib/Expression.rb"
require "test/unit"

class TestExpression < Test::Unit::TestCase

  def setup
    @exp = MathExpression.new
  end

  def test_it_should_work_for_single_digits
    assert_equal @exp.eval('3'), 3
  end

  def test_it_should_work_with_unary_signs
    assert_equal @exp.eval('+2'), 2
    assert_equal @exp.eval('-3'), -3
  end

  def test_it_should_work_with_floats
    assert_equal @exp.eval('.5'), 0.5
    assert_equal @exp.eval('0.5'), 0.5
    assert_equal @exp.eval('-.045'), -0.045
  end

  def test_it_should_work_with_basic_arithmetic
    assert_equal @exp.eval('1+1'), 2
    assert_equal @exp.eval('11+1'), 12
    assert_equal @exp.eval('1-1'), 0
    assert_equal @exp.eval('1.1 + 2.1'), 3.2
    assert_equal @exp.eval('2*3'), 6
    assert_equal @exp.eval('-4/2'), -2
    assert_equal @exp.eval('3/2'), 1.5
    assert_equal @exp.eval('2^3'), 8
  end

  def test_it_should_follow_pemdas_rule
    assert_equal @exp.eval('9-2*3'), 3
    assert_equal @exp.eval('9+3/2'), 10.5
    assert_equal @exp.eval('(9+3)/2'), 6
    assert_equal @exp.eval('(9+3)/[2- 1]'), 12
    assert_equal @exp.eval(' 8 - (7 - 6) + 5'), 12
    assert_equal @exp.eval('9 - 6*7^(1+2)'), -2049
    assert_equal @exp.eval('9^2*3'), 243

  end

  def test_factorial_and_modulo
    assert_equal @exp.eval('5!'), 120
    assert_equal @exp.eval('5! +2'), 122
    assert_equal @exp.eval('(3+4)! * 2 + 1'), 10081
    assert_equal @exp.eval('9 % 6'), 3
    assert_raise(InvalidInput) { @exp.eval('6.43!')  }
  end

  def test_functions
    assert_equal @exp.eval('sqrt(25)'), 5
    assert_raise(Math::DomainError) { @exp.eval('sqrt(-2253)')  }
    assert_equal @exp.eval('root3(27)'), 3
    assert_equal @exp.eval('cos(0)'), 1
    assert_equal @exp.eval('sin(0)'), 0
    assert_equal @exp.eval('tan(0)'), 0
    assert_equal @exp.eval('arccos(1)'), 0
    assert_equal @exp.eval('arcsin(0)'), 0
    assert_equal @exp.eval('arctan(0)'), 0
    assert_in_delta @exp.eval('exp(1)'), 2.71, 0.01
    assert_equal @exp.eval('ln(exp(1))'), 1
    assert_equal @exp.eval('log(10)'), 1
    assert_equal @exp.eval('log2(2)'), 1
    assert_equal @exp.eval('arccosh(cosh(2))'), 2
    assert_equal @exp.eval('arcsinh(sinh(2))'), 2
    assert_in_delta @exp.eval('arctanh(tanh(2))'), 2, 0.0001
    assert_in_delta @exp.eval('cosh(1)'), 1.54, 0.01
    assert_in_delta @exp.eval('sinh(1)'), 1.17, 0.01
    assert_in_delta @exp.eval('tanh(1)'), 0.76, 0.01
  end


  def test_errors
    assert_raise(InvalidInput) { @exp.eval('312c5')  }
    assert_raise(InvalidInput) { @exp.eval('3+')  }
    assert_raise(InvalidInput) { @exp.eval('3^')  }
    assert_raise(IndeterminedForm) { @exp.eval('0/0')  }
    assert_raise(InvalidInput) { @exp.eval('some random stuff')  }
    assert_raise(InvalidInput) { @exp.eval('+')  }
    assert_raise(InvalidInput) { @exp.eval('root(3)')  }
    assert_raise(IndeterminedForm) { @exp.eval('3/0')  }
  end

end
