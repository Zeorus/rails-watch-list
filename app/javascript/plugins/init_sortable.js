import Sortable from 'sortablejs';
import swal from 'sweetalert';

const initSortable = () => {
  const trash = document.querySelector('#trash-delete-items');
  const listsContainer = document.getElementById('cards-sortable');
  
  new Sortable(listsContainer, {
    group: {
      name: 'shared',
      put: false // Do not allow items to be put into this list
    },
    animation: 150,
    sort: false,
    onEnd: (event) => {
      const cardToDelete = event.item;
      if (event.to.id == "trash-delete-items") {
        cardToDelete.classList.add('card-delete');
        cardToDelete.style.display = 'none';

        swal({
          title: "Attention",
          text: "Êtes-vous sûr de vouloir supprimer cette liste ? Tous les films qui en font parti seront retirés.",
          icon: "warning",
          closeOnClickOutside: false,
          closeOnEsc: false,
          dangerMode: true,
          buttons: ["Annuler", "Confirmer"]
        }).then((value) => {
          if (value) {
            $.ajax({
              type: "DELETE",
              url: `/lists/${cardToDelete.dataset.itemId}`,
            });
          } else {
            window.location.reload();
          }
        })
      }
    }
  });

  new Sortable(trash, {
    group: 'shared',
    animation: 150
  });
};

export { initSortable };