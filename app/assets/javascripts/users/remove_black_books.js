function deleteThis(bb) {

	var $this = bb;
	var item = $this.parentsUntil('.listing').parent();
	var clear_item = item.next()[0]; 
	if (confirm("Do you really want to delete this black book?")) {
		removeThisThing(item);
		removeThisThing(clear_item);
	}
	return false;
}