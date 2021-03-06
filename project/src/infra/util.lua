module(..., package.seeall)
-- --------------------------------------------------------------------------
-- --------------------------------------------------------------------------
-- Métodos utilitários para o sistema
-- --------------------------------------------------------------------------
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- Remoção de objetos
-- --------------------------------------------------------------------------
function removeObject(object, group)
	if group then group:remove( object ); end
  	if object then object:removeSelf(); object = nil; end 
end

-- --------------------------------------------------------------------------
--
-- --------------------------------------------------------------------------