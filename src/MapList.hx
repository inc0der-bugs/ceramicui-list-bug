import haxe.ui.events.MouseEvent;
import haxe.ui.containers.TreeViewNode;
import haxe.ui.containers.TreeView;

@:build(haxe.ui.ComponentBuilder.build('../../assets//maplist.xml'))
class MapList extends TreeView {
  public var worldNode: TreeViewNode;

  public function new() {
    super();
    worldNode = addNode({ text: 'World' });
    worldNode.expanded = true;
    var mapInfo = '<?xml version="1.0" encoding="UTF-8"?>
<maps>
  <map id="1" name="Map Test" path="./MapTest.tmx">
    <map id="2" name="Map Child Test" path="./MapTest.tmx">
      <map id="3" name="Map Child Test 2" path="./MapTest.tmx"></map>
      <map id="4" name="Map Child Test 3" path="./MapTest.tmx"></map>
    </map>
    <map id="2" name="Map Child Test" path="./MapTest.tmx">
      <map id="3" name="Map Child Test 2" path="./MapTest.tmx"></map>
      <map id="4" name="Map Child Test 3" path="./MapTest.tmx"></map>
    </map>
  </map>
  <map id="1" name="Map Test" path="./MapTest.tmx">
    <map id="2" name="Map Child Test" path="./MapTest.tmx">
      <map id="3" name="Map Child Test 2" path="./MapTest.tmx"></map>
      <map id="4" name="Map Child Test 3" path="./MapTest.tmx"></map>
    </map>
    <map id="2" name="Map Child Test" path="./MapTest.tmx">
      <map id="3" name="Map Child Test 2" path="./MapTest.tmx"></map>
      <map id="4" name="Map Child Test 3" path="./MapTest.tmx"></map>
    </map>
  </map>
</maps>';
    var data = Xml.parse(mapInfo);
    createNodesFromXml(data.firstElement());
  }

  private function createNodesFromXml(xmlData: Xml, ?parentNode: TreeViewNode) {
    var maps = xmlData.elements();

    if (parentNode == null) {
      parentNode = worldNode;
    }

    for (map in maps) {
      var name = map.get('name');
      var children = map.elements();
      var node = parentNode.addNode({ text: name });

      // node.expanded = true;

      if (children.hasNext()) {
        createNodesFromXml(map, node);
      }
    }
  }
}
