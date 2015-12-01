function [] = KeyPress( funcKeyNum, csa )
%KEYPRESS Summary of this function goes here
%   Detailed explanation goes here
%java.awt.event.KeyEvent.VK_F11 = 122;

import java.awt.Robot
import java.awt.event.*
keys = Robot;
if ~isempty(strfind(csa,'c'))
    keys.keyPress(java.awt.event.KeyEvent.VK_CONTROL ) 
end
if ~isempty(strfind(csa,'s'))
    keys.keyPress(java.awt.event.KeyEvent.VK_SHIFT ) 
    
end
if ~isempty(strfind(csa,'a'))
    keys.keyPress(java.awt.event.KeyEvent.VK_ALT ) 
end
keys.keyPress( funcKeyNum )
fprintf('Key num: %d is pressed', funcKeyNum);
keys.keyRelease( funcKeyNum ) 
if ~isempty(strfind(csa,'c'))
    keys.keyRelease(java.awt.event.KeyEvent.VK_CONTROL ) 
    fprintf(', with CTRL');
end
if ~isempty(strfind(csa,'s'))
    keys.keyRelease(java.awt.event.KeyEvent.VK_SHIFT ) 
    fprintf(', with SHIFT');
end
if ~isempty(strfind(csa,'a'))
    keys.keyRelease(java.awt.event.KeyEvent.VK_ALT ) 
    fprintf(', with ALT');
end
fprintf('\n');
end

