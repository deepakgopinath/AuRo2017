c = allchild(gca);

for i=1:length(c)
    if isa(c(i), 'matlab.graphics.primitive.Line')
        original_color = c(i).Color;
        new_color = [original_color, 0.4];
        c(i).Color = new_color;
    end
end