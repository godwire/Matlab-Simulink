% Differentiated equation for y(k)
function out = deq_yk(URO, maxk)
  num = URO.num;
  den = URO.den;
  
  order_y = length(den) - 1;
  order_w = length(num) - 1;
  
  y = zeros(1, maxk);
  w = ones(1, maxk);  % w(k) = 1

  for k = 1:maxk
      sum_y = 0;
      sum_w = 0;

      for j = 1:order_y
          if (k-j) > 0
              sum_y = sum_y - den(j+1) * y(k-j);
          end
      end

      for j = 0:order_w
          if (k-j) > 0
              sum_w = sum_w + num(j+1) * w(k-j);
          end
      end

      y(k) = (sum_w + sum_y) / den(1);
  end

  out = y;
end

