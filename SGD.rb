#Fit a Least Squares Regression Line

trainingdata = [[4,3],[2,5],[2,6],[5,7],[2,5],[8,6],[6,7],[1,2],[1,4]]
parameter_intercept = 50
parameter_slope = -24
step_size = 0.000001

def objfunc(intercept, slope, dataset)
	sum = 0
	dataset.each {|node|
		sum += (intercept + (slope * node[0]) - node[1]) ** 2
	}
	return sum
end

def derivative_slope(intercept, slope, dataset)
	sum = 0
	k = 0
	dataset.each {|node|
		sum += -node[0] * (node[1] - (slope * node[0] + intercept))
		k += 1
	}
	return sum
end

def derivative_intercept(intercept, slope, dataset)
	sum = 0
	k = 0
	dataset.each {|node|
		sum += -(node[1] - (slope * node[0] + intercept))
		k += 1
	}
	return sum
end

def descent(interceptinit, slopeinit, step_size, dataset)
	data = dataset.dup
	intercept = interceptinit
	slope = slopeinit
	oldslope = 1000
	oldintercept = 1000
	j = 0
	until (slope - oldslope).abs < (step_size/10000) && (intercept - oldintercept).abs < (step_size/100)
		slope_gradient = derivative_slope(intercept, slope, dataset)
		intercept_gradient = derivative_intercept(intercept, slope, dataset)
		oldslope = slope.dup
		oldintercept = intercept.dup
		slope = slope - step_size * slope_gradient
		intercept = intercept - step_size * intercept_gradient
		j += 1
		print "slope: #{slope}, intercept: #{intercept}, objective: #{objfunc(intercept, slope, dataset)}, i: #{j}\n" if j % 1000 == 0
	end
	return [intercept, slope]
end

descent(parameter_intercept, parameter_slope, step_size, trainingdata)